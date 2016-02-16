require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
	def setup 
		@user = User.new(name: "foo", email: "foo@bar.com",
										 password: "foobar", password_confirmation: "foobar")

	end 

	test "should be valid" do
		assert @user.valid?
	end

	test "should require name" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "should require email" do
		@user.email = "a" * 255
		assert_not @user.valid?
	end

	test "email validation should accept valid email address" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp jon+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "{valid_address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid email address" do
		invalid_addresses = %w[user@example,com user@foo user_at_foo.org user.name@example@foo.bar.baz user@foo+bar]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "{invalid_addresses.inspect} should be invalid"
		end
	end

	test "email address should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
		mixed_case_email = "bLiP@exAmPle.cOM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	test "password should be present" do
			@user.password = @user.password_confirmation = " " * 6
			assert_not @user.valid?
	end

	test "password should have a minimum length" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end



end
