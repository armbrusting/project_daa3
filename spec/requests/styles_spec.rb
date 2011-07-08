require 'spec_helper'

describe "Styles" do
  
  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new style" do
        lambda do 
          user = Factory(:user)
          visit signin_path
          # The test automatically follows the redirect to the signin page.
          fill_in :email,    :with => user.email
          fill_in :password, :with => user.password
          click_button
          # The test follows the redirect again, this time to style/new.
          visit newstyle_path
          fill_in "Number",         :with => ""
          click_button
          response.should render_template('styles/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Style, :count)
      end
      
      describe "success" do

        it "should make a new style" do
          lambda do
            user = Factory(:user)
            visit signin_path
            fill_in :email,    :with => user.email
            fill_in :password, :with => user.password
            click_button
            visit newstyle_path
            fill_in "Number",         :with => "DA-999999"
            click_button
            response.should have_selector("div.flash.success",
                                          :content => "Style created!")
            response.should render_template('styles/show')
          end.should change(Style, :count).by(1)
        end
      end
    end      
  end
end
