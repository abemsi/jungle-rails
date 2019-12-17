require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    it "should not be created without a password and password_confirmation" do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it "should be created with matching password and password_confirmation fields" do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it "should not be created without matching password and password_confirmation fields" do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: "password", password_confirmation: "password123")
      expect(@user).to_not be_valid
    end

    it "should not be created without an email" do
      @user = User.new(name: "Bill Gates", email: nil, password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it "should not be created without a name" do
      @user = User.new(name: nil, email: "billgates@gmail.com", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it 'should not be created if the email is not unique' do
      @user = User.new(name: "Steve Jobs", email: "BILLgates@gmail.com", password: "password123", password_confirmation: "password123")
      expect(@user).to validate_uniqueness_of(:email)
    end

    it 'should not be created if the password is shorter than 5 characters' do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: "1234", password_confirmation: "1234")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should login a user with the proper credentials' do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      authenticate = @user.authenticate_with_credentials(@user.email, @user.password)
      expect(authenticate).to be_truthy
    end

    it 'should login a user if there are spaces before and/or after their email' do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      authenticate = @user.authenticate_with_credentials(" billgates@gmail.com ", "password")
      expect(authenticate).to be_truthy
    end

    it 'should login a user if the email is typed in the wrong case' do
      @user = User.new(name: "Bill Gates", email: "billgates@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      authenticate = @user.authenticate_with_credentials("billGATES@gmail.COM", "password")
      expect(authenticate).to be_truthy
    end

  end
end