class TimecardsController < ApplicationController
	def index
		@timecards = Timecard.where("user_id = ?",current_user.id )
	end

	def show
		# 出退勤記録済確認用
		@newcard = Timecard.new
		@timecard = Timecard.find_by(user_id:current_user.id, year:Date.today.year, month:Date.today.month, day:Date.today.day)
	end

	def create
		# 出勤記録用
		newcard = Timecard.new(timecard_params)
		newcard.save
		redirect_to timecard_path(current_user)
	end

	def update
		# 退勤記録用
		timecard = Timecard.find(params[:id])
		timecard.update(timecard_params)
		redirect_to timecard_path(current_user)
	end

	private

	def timecard_params
		params.require(:timecard).permit(:year,:month,:day,:in_time,:out_time,:user_id)
	end
end
