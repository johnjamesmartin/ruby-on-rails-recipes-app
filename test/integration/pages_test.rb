require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  
  # 1. Issue GET request to ~/pages/home and assert response request:

  test "should get home" do
    get pages_home_url
    assert_response :success
  end


  # 2. Issue GET request to the root route and assert response request:

  test "should get root" do
    get root_url
    assert_response :success
  end

end
