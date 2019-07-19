require 'csv'

CSV.generate do |csv|
  column_names = %w(day date intime outtime amount)
  csv << column_names
  @unites.each do |date,time|
  	intime = ""
  	  if time == "00:00"
		intime = time
	  elsif time.in_time == nil
		intime ="00:00"
	  elsif time.in_time != nil
		 intime = time.in_time.strftime('%H:%M')
	  end
  	outtime = ""
	if time == "00:00"
		outtime = time
	 elsif time.out_time == nil
		outtime = "00:00"
	 elsif time.out_time != nil
		outtime = time.out_time.strftime('%H:%M')
	end
  	amount = ""
  	if time == "00:00"
		amount = time
	elsif time.in_time == nil || time.out_time == nil
		amount = "要連絡"
	elsif time.in_time != nil || time.out_time != nil
		amount = Time.at(time.out_time - time.in_time).strftime('%-H時間%-M分')
	end
    column_values = [
      date.strftime('%-m月%-d日'),
	  date.strftime("#{%w(日 月 火 水 木 金 土)[date.wday]}"),
	  intime,
	  outtime,
	  amount
    ]
    csv << column_values
  end
end