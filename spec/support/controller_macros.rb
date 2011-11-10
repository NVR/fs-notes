module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(:id => '1', :email => 'some@shit.cim', :password => 'someshit')
      sign_in user
    end
  end
end
