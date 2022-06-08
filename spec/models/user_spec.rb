require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before :each do
      @user = User.new({ name: 'Sara', email: 'saracrystal@email.com', password: '1234', password_confirmation: '1234', last_name: 'Crystal' })
    end
    
    it 'needs a first name' do
      @user.name = nil
      @user.save
      expect(@user.errors.full_messages).to include ("First name is missing")
    end
    it 'needs a last name' do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include ("Last name is missing")
    end

    it 'must save properly when all fields are filled properly' do
      @user.save
      expect(@user.save).to eq true 
    end

    it 'makes sure password and password_confirmation match' do
      @user.password_confirmation = '0123'
      @user.save
      expect(@user.errors.full_messages).to include ("Password confirmation doesn't match")
    end

    it 'needs password and password_confirmation to be filled' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save
      expect(@user.errors.full_messages).to include ("Password is missing")
    end
    
    it 'needs an email' do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include ("Email is missing")
    end

    it 'makes sure email is unique, no matter the cases' do
      @user.save
      @user2 = User.new ({ name: 'Sara', email: 'SARACRYSTAL@EMAIL.COM', password: '1234', password_confirmation: '1234', last_name: 'Crystal' })
      @user2.save
      expect(@user2.errors.full_messages).to include ("Email already exists")
    end

    it 'makes sure password has at least 8 characters' do
      @user.password = "123"
      @user.password_confirmation = "123"
      @user.save
      expect(@user.errors.full_messages).to include ("Make sure password has at least 8 characters")
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = User.new({ name: 'Sara', email: 'saracrystal@email.COM', password: '1234', password_confirmation: '1234', last_name: 'Crystal' })
      @user.save
    end

    it 'should be case insensitive for email address' do
      expect(User.authenticate_with_credentials('SARACRYSTAL@EMAIL.com', @user.password)).to eq @user
    end

    it 'must successully authenticate and create a session if password matches' do
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq @user
    end

    it 'should remove white space before and after email' do
      expect(User.authenticate_with_credentials('saracrystal@email.CoM  ', @user.password)).to eq @user
    end
  end
end