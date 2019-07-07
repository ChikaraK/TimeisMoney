class TimecardsController < ApplicationController

	def index
	end

	def show
		# 出勤記録済確認用
		# @timecard = Timecard.find(params[:id])
	end

	def create
		# 出勤記録用
		@newcard = Timecard.new
	end
end
