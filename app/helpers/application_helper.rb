module ApplicationHelper
	def flash_msg(login=false)
    builder = ""
    if flash.count > 0
      return render partial: "layouts/notifier"
    end
  end
end
