require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  
  # 1. Issue GET request to ~/signup/ and assert response request:

  test "should get signup path" do
    get signup_path
    assert_response :success
  end


  # 2. Reject invalid chef signup:

  test "reject invalid signup" do
    get signup_path
    assert_no_difference "Chef.count" do
      post chefs_path, params: { chef: { chefname: " ", email: " ", password: "password", password_confirmation: " " } }
    end
    assert_template 'chefs/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end


  # 3. Accept valid chef signup:

  test "accept valid signup" do
    get signup_path
    assert_difference "Chef.count", 1 do
      post chefs_path, params: { chef: { chefname: "mashrur", email: "mashrur@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
