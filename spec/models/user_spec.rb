require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "validates the presence of  first name" do 
      @user = User.new(first_name: nil, last_name:"test", email: "test@test.com", password: "test", password_confirmation: "test")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("First name can't be blank")
    end 

    it "validates the presence of last name" do 
      @user = User.new(first_name: "test", last_name: nil,  email: "test@test.com", password: "test",password_confirmation: "test")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
    end 

    it "validates the presence of email" do 
      @user = User.new(first_name: "test", last_name: "2test",  email: nil, password: "test12", password_confirmation: "test12")
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end 

    it "must be created with a password and password_confirmation fields" do
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoss.agina@telus.com", password:"yalla", password_confirmation:"yalla")
      @user.save
      expect(@user).to be_present
    end

    it "password and password_confirmation fields must match" do
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoss.agina@telus.com", password:"yalla", password_confirmation:"DIFFERENT password")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "requires password if password = nil" do
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoss.agina@telus.com", password:nil, password_confirmation:"DIFFERENTpassword")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "requires password if password_confirmation = nil" do
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoss.agina@telus.com", password:"somepassword", password_confirmation:nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "emails should be unique case sensitive " do 
      @user = User.new(first_name: "test", last_name: "2test",  email: "test@test.com" , password: "test12", password_confirmation:"test12" )
      @user.save
      @user2 =User.new(first_name: "2test", last_name: "test",  email: "test@test.COM" , password: "2test1", password_confirmation: "2test1" )
      expect(@user2).not_to be_valid 
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it "emails should be unique NOT case sensitive " do 
      @user = User.new(first_name: "test", last_name: "2test",  email: "test@test.com" , password: "test12", password_confirmation:"test12" )
      @user.save
      @user2 =User.new(first_name: "2test", last_name: "test",  email: "test@test.com" , password: "2test1", password_confirmation: "2test1" )
      expect(@user2).not_to be_valid 
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it "password should have minimum 3 charaters " do 
      @user = User.new(first_name: "test", last_name: "2test",  email: "test@test.com" , password: "test", password_confirmation: "test" )
      expect(@user).not_to be_valid 
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 5 characters)")
    end  
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate with credentials" do 
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoSs.aGiNa@TELus.cOm", password:"yalla", password_confirmation:"yalla" )
      @user.save 
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end


    it "should not authenticate with invalid email" do 
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoSs.aGiNa@TELus.cOm", password:"yalla", password_confirmation:"yalla" )
      @user.save 
      expect(User.authenticate_with_credentials("differentemail@test.com", @user.password)).to be_nil
    end

    it "should not authenticate with invalid password" do 
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoSs.aGiNa@TELus.cOm", password:"yalla", password_confirmation:"yalla" )
      @user.save 
      expect(User.authenticate_with_credentials(@user.email, "incorrectpassword")).to be_nil
    end

    it "should authenticate with extra spaces before email" do 
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoSs.aGiNa@TELus.cOm", password:"yalla", password_confirmation:"yalla")
      @user.save 
      expect(User.authenticate_with_credentials("   hoss.agina@telus.com",@user.password)).to eq(@user)
    end


    it "should authenticate with wrong case email" do 
      @user = User.new(first_name:"Hoss", last_name:"Agina", email:"hoSs.aGiNa@TELus.cOm", password:"yalla", password_confirmation:"yalla")
      @user.save 
      expect(User.authenticate_with_credentials("hoss.AGINA@telUS.CoM",@user.password)).to eq(@user)
    end
  end
end
