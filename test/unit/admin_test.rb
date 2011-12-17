require 'test_helper'

class AdminTest < ActiveSupport::TestCase
	fixtures :admins
	test "admin_valido" do
		admin = Admin.new(:email => "teste@teste.com", :password => "123456", 
		:password_confirmation => "123456", :idref => "1", :tipo => "1")
		assert admin.save
	end

	test "email_invalido" do
		admin = Admin.new(:email => "teste", :password => "123456", 
		:password_confirmation => "123456", :idref => "1", :tipo => "1")
		assert admin.invalid?
		assert !admin.save
	end

	test "password_invalida" do
		admin = Admin.new(:email => "teste@gmail.com", :password => "123456", 
		:password_confirmation => "12345", :idref => "1", :tipo => "1")

		assert admin.invalid?
		assert !admin.save
	end
end
