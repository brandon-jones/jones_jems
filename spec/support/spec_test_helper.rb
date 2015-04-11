module SpecTestHelper   
  def login_admin
    @admin = FactoryGirl.create(:user, email: 'admin@test.com', admin: true)
    request.session[:user_id] = @admin.id
  end

  def login_user
    @user = FactoryGirl.create(:user, email: 'user@test.com')
    request.session[:user_id] = @user.id
  end
end