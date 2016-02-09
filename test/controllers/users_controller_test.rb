require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @base_title = "Ruby on Rails Twitter Clone"
  end

  test "should get signup" do
    get :new
    assert_response :success
    assert_select "title", "Sign Up | #{@base_title}"
  end

end