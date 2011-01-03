require 'spec_helper'

describe SessionsController do  
  render_views
  
    before(:each) do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out :user
      sign_in Factory(:user)
      authenticate_user!
    end
   
   describe "DELETE 'destroy'" do

     it "should sign a user out" do
       delete :destroy
       flash[:notice].should == "Signed out successfully."
       response.should redirect_to(root_path)
     end
   end

   describe "GET 'new'" do

     it "should be successful" do
       get :new
       response.should be_success
     end

     it "should have the right title" do
       get :new
       response.should have_selector("title", :content => "Sign in")
     end
   end

   describe "POST 'create'" do

     describe "with valid email and password" do

       before(:each) do
         sign_out :user
         @user = Factory(:user)
         @attr = { :email => @user.email, :password => @user.password }
       end

       it "should sign the user in" do
         sign_in @attr
         #post :create, :session => @attr
         controller.current_user.should == @user
         controller.should be_signed_in
       end

       it "should redirect to the user show page" do
         sign_in @attr
         #post :create, :session => @attr
         response.should redirect_to(user_path(@user))
       end
     end

     describe "invalid signin" do

       before(:each) do
         @attr = { :email => "email@example.com", :password => "invalid" }
       end

       it "should re-render the new page" do
         sign_in @attr
         #post :create, :session => @attr
         response.should render_template('new')
       end

       it "should have the right title" do
         sign_in @attr
         #post :create, :session => @attr
         response.should have_selector("title", :content => "Sign in")
       end

       it "should have a flash.now message" do
         sign_in @attr
         #post :create, :session => @attr
         flash.now[:error].should =~ /invalid/i
       end
     end
   end

end
