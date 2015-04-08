module SpecTestHelper   
  def login_admin
    user = FactoryGirl.create(:user, admin: true)
    request.session[:user_id] = user.id
  end

  def login_user
    user = FactoryGirl.create(:user)
    request.session[:user_id] = user.id
  end
end