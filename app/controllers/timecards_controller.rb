class TimecardsController < ApplicationController
	def index
	end

	def show
		# 出退勤記録済確認用
		@newcard = Timecard.new
		@timecard = Timecard.find(params[:id])
	end

	def create
		# 出勤記録用
		newcard = Timecard.new(timecard_params)
		newcard.save
		redirect_to timecards_path
	end

	def update
		# 退勤記録用
		timecard = Timecard.find(params[:id])
		timecard.update(timecard_params)
		redirect_to timecards_path
	end

	private

	def timecard_params
		params.require(:timecard).permit(:year,:month,:day,:in_time,:out_time,:user_id)
	end
end
