require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup credentials" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: {  name: "",
																email: "user@fail.com",
																password: 						 "snake",
																password_confirmation: "balls" }

		end
		assert_template "users/new"	
	end

	test "valid signup credentials" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: { name: "Snake",
																						email: "snake@balls.com",
																						password: 						 "snake_balls_bits",
																						password_confirmation: "snake_balls_bits" }

		end
		assert_template "users/show"	
	end

end