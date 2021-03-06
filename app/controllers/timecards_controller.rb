class TimecardsController < ApplicationController
before_action :authenticate_user!
	def index
		# 勤怠データ
		@timecards = Timecard.where("user_id = ?",current_user.id )
		# 月データ
		@monthly = Date.today.beginning_of_month..Date.today.end_of_month
		# 勤怠データ入れ
		@unites = {}
		# 勤怠データと月データ合算
		@monthly.each do |m|
			@timecards.each do |t|
				if m.day == t.day && m.month == t.month 
				  @unites.store(m,t)
				  break
				else
				   @unites.store(m,"00:00")
				end
			end
		end
		respond_to do |format|
			format.html
			format.csv do
				send_data render_to_string, filename: "index.csv", type: :csv
			end
		end
	end

	def show
		# 出退勤記録済確認用
		@newcard = Timecard.new
		@timecard = Timecard.find_by(user_id:current_user.id, year:Date.today.year, month:Date.today.month, day:Date.today.day)
	end

	def create
		# 出勤記録用
		newcard = Timecard.new(timecard_params)
		if newcard.save
			notifier = Slack::Notifier.new "#{ENV["SLACK_URL"]}"
			notifier.ping "出勤！！#{Time.zone.now.strftime('%H:%M')}"
			redirect_to timecard_path(current_user)
		end
	end

	def update
		# 退勤記録用
		timecard = Timecard.find(params[:id])
		if timecard.update(timecard_params)
			notifier = Slack::Notifier.new "#{ENV["SLACK_URL"]}"
			notifier.ping "退勤！！#{Time.zone.now.strftime('%H:%M')}"
			redirect_to timecard_path(current_user)
		end
	end

	private

	def timecard_params
		params.require(:timecard).permit(:year,:month,:day,:in_time,:out_time,:user_id)
	end

	def check_user
 		@user = User.find(params[:id])
  		redirect_to new_user_session_path unless @user == current_user
	end
end
