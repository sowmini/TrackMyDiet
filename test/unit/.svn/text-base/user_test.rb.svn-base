require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "user_validity" do
  
	user = User.new
	assert !user.valid?
	#Check id there is an error assoc. to every validated attribute
	assert user.errors.invalid?(:firstname)	
	assert user.errors.invalid?(:lastname)	
	assert user.errors.invalid?(:username)	
	assert user.errors.invalid?(:password)
	assert user.errors.invalid?(:email)
	
  end
  
  #Test the length validation on name and phone attributes
  test "length_of_all_attributes" do
	user = User.new(		:username => "AAAAAAAA12344",
							:firstname => "AAAAAAA",
							:lastname => "AAAAAAA",
							:password => "sun",
							:email => "a@b.com")
	
	#Check if the error messages of validations work 
	
	user.username = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	assert !user.valid?
	assert_equal "is too long (maximum is 20 characters)", user.errors.on(:username)
	
	user.username = "sowmini2087"
	assert !user.valid?
	
	user.firstname = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	assert !user.valid?
	assert_equal "is too long (maximum is 20 characters)", user.errors.on(:firstname)
	
	user.firstname = "sowmini"
	assert !user.valid?
		
	user.lastname = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	assert !user.valid?
	assert_equal "is too long (maximum is 20 characters)", user.errors.on(:lastname)
	
	user.lastname = "gundamraju"
	assert !user.valid?
	
	user.email = "unvalid_email_format"
	assert !user.valid?
	assert_equal "must be a valid email address", user.errors.on(:email)
	
	user.email = "abc@gmail.com"
	assert !user.valid?
	
  end
   
end