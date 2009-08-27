# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def simple_date(time = Time.now)
		 time.strftime("%d.%m.%y")
	end 

end
