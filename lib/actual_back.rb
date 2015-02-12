# lib/money_attributes.rb
module ActualBack
  def set_last_path path
  	unless @path == false
    	session[:_tl_last_path] = path unless path == '/login' || path == '/logout'
    end
  end

  def last_path
    return session[:_tl_last_path] || '/'
  end
end