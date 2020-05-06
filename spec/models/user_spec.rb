require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject do
      described_class.new(
        email: 'user@email.com',
        name: 'Linh',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid with unmatching password and password_confirmation' do
      subject.password_confirmation = 'some_other_password'
      expect(subject).to_not be_valid
    end

    it 'is invalid when password or password_confirmation is not provided' do
      subject.password = nil
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when name is not provided' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when email is not provided' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when email is already taken' do
      @user1 =
        User.new(
          name: 'Linh',
          email: 'user@email.com',
          password: 'password',
          password_confirmation: 'password'
        )
      @user1.save!

      new_user2 =
        User.new(
          email: 'user@email.com',
          name: 'Linh',
          password: 'password',
          password_confirmation: 'password'
        )
      expect(new_user2).to_not be_valid
    end

    it 'is invalid when password is less than 8 characters' do
      subject.password = 'invalid'
      subject.password_confirmation = 'invalid'
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'is should not login if password is incorrect' do
      user =
        User.new(
          email: 'user@email.com',
          name: 'Linh',
          password: 'password',
          password_confirmation: 'password'
        )
      user.save!
      expect(user).to be_valid
      expect(
        User.authenticate_with_credentials(
          'user@email.com',
          'password_incorrect'
        )
      ).to_not eq(user)
    end
    it 'is should not login if email is incorrect' do
      user =
        User.new(
          email: 'user@email.com',
          name: 'Linh',
          password: 'password',
          password_confirmation: 'password'
        )
      user.save!
      expect(user).to be_valid
      expect(
        User.authenticate_with_credentials(
          'test_incorrect@test.com',
          'password'
        )
      ).to_not eq(user)
    end
    it 'is should login if there are sapce before or after email' do
      user =
        User.new(
          email: 'user@email.com',
          name: 'Linh',
          password: 'password',
          password_confirmation: 'password'
        )
      user.save!
      expect(user).to be_valid
      expect(
        User.authenticate_with_credentials('   user@email.com  ', 'password')
      ).to eq(user)
    end
    it 'is should login if case for email is different' do
      user =
        User.new(
          email: 'user@email.com',
          name: 'Linh',
          password: 'password',
          password_confirmation: 'password'
        )
      user.save!
      expect(user).to be_valid
      expect(
        User.authenticate_with_credentials('USER@email.com', 'password')
      ).to eq(user)
    end
  end
end
