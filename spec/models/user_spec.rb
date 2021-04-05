require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a User if all of the fields are filled correctly' do
      @user = User.new(first_name: "George", last_name: "Fisher", email: "George@Corpsegrinder.com", password: "blegh", password_confirmation: "blegh")
      @user.valid?
      expect(@user.errors).not_to include("can\'t be blank")
    end

    it 'should prevent user creation if the first name field is empty' do
      @user = User.new(last_name: "Fisher", email: "George@Corpsegrinder.com", password: "blegh", password_confirmation: "blegh")
      @user.valid?
      expect(@user.errors[:first_name]).to include("can\'t be blank")
    end 

    it 'should prevent user creation if the last name field is empty' do
      @user = User.new(first_name: "George", email: "George@Corpsegrinder.com", password: "blegh", password_confirmation: "blegh")
      @user.valid?
      expect(@user.errors[:last_name]).to include("can\'t be blank")
    end 

    it 'should prevent user creation if the email field is empty' do
      @user = User.new(first_name: "George", last_name: "Fisher", password: "blegh", password_confirmation: "blegh")
      @user.valid?
      expect(@user.errors[:email]).to include("can\'t be blank")
    end 

    it 'should prevent user creation if email is already in use by another user' do
      @user = User.new(first_name: "George", last_name: "Fisher", email: "George@Corpsegrinder.com", password: "blegh", password_confirmation: "blegh")
      @user.save
      @user2 = @user = User.new(first_name: "George", last_name: "Martin", email: "GeOrge@corpsegrinder.com", password: "blegh", password_confirmation: "blegh")
      @user2.save
      @user2.valid?
      expect(@user2.errors[:email]).to include("has already been taken")
    end 

    it 'should prevent user creation if the password field is empty' do
      @user = User.new(last_name: "Fisher", email: "George@Corpsegrinder.com", password: nil, password_confirmation: "blegh")
      @user.valid?
      expect(@user.errors[:password]).to include("can\'t be blank")
    end 

    it 'should prevent user creation if the passwords don\'t match' do
        @user = User.new(last_name: "Fisher", email: "George@Corpsegrinder.com", password: "blegh", password_confirmation: "blagh")
        @user.valid?
        expect(@user.errors[:password_confirmation]).to be_present
    end

    it 'should prevent user creation if the password is not long enough' do
      @user = User.new(first_name: "George", last_name: "Fisher", email: "George@Corpsegrinder.com", password: "bleg", password_confirmation: "bleg")
      @user.valid?
      expect(@user.errors[:password]).to be_present
    end
end

describe '.authenticate_with_credentials' do
  it 'should log the user in if the credentials are correct' do
    @user = User.new(first_name: "George", last_name: "Fisher", email: "george666@gmail.com", password: "FISHER", password_confirmation: "FISHER")
    @user.save!
    expect(User.authenticate_with_credentials("george666@gmail.com", "FISHER")).not_to be(nil)
  end
  
  it 'should not log the user in if the email is incorrect' do
    @user = User.new(first_name: "George", last_name: "Fisher", email: "george666@gmail.com", password: "FISHER", password_confirmation: "FISHER")
    @user.save!
    expect(User.authenticate_with_credentials("george666@gmail.com", "FASHER")).to be(nil)
  end 

  it 'should log the user in if the use the wrong case in the email' do
    @user = User.new(first_name: "George", last_name: "Fisher", email: "george666@gmail.com", password: "FISHER", password_confirmation: "FISHER")
    @user.save!
    expect(User.authenticate_with_credentials("gEorge666@gmail.com", "FISHER")).not_to be(nil)
  end 

  it 'should log the user in even if they add spaces to the email' do
    @user = User.new(first_name: "George", last_name: "Fisher", email: "george666@gmail.com", password: "FISHER", password_confirmation: "FISHER")
    @user.save!
    expect(User.authenticate_with_credentials(" gEorge666@gmail.com   ", "FISHER")).not_to be(nil)
  end 
    
end 
end 
