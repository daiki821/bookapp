# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  introduction           :text
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'ユーザー名とEメールとパスワードが入力されている場合' do
    let!(:user) { build(:user) }

    it 'ユーザー登録ができる' do
      expect(user).to be_valid
    end

  end

  context 'ユーザー名が未入力の場合' do
    let!(:user) { build(:user, username: '' ) }

    before do
      user.save
    end

    it '保存できない' do
      expect(user.errors.messages[:username][0]).to eq('を入力してください')
    end
  end

  context 'Eメールが未入力の場合' do
    let!(:user) { build(:user, email: '' ) }

    before do
      user.save
    end

    it '保存できない' do
      expect(user.errors.messages[:email][0]).to eq('を入力してください')
    end
  end

  context 'パスワードが未入力の場合' do
    let!(:user) { build(:user, password: '' ) }

    before do
      user.save
    end

    it '保存できない' do
      expect(user.errors.messages[:password][0]).to eq('を入力してください')
    end
  end

  context 'パスワードが6文字以上だった場合' do
    let!(:user) { build(:user, password: 'aaaaaa') }

    before do
      user.save
    end

    it '保存できる' do
      expect(user).to be_valid
    end
  end

  context 'パスワードが６文字以下だった場合' do
    let!(:user) { build(:user, password: 'aaaaa') }

    before do
      user.save
    end

    it '保存できない' do
      expect(user.errors.messages[:password][0]).to eq('は6文字以上で入力してください')
    end
  end

  context 'ユーザー名が他のユーザーと一緒だった場合' do
    let!(:user) { create(:user, username: 'taro') }

    before do
      @user = User.new(username: 'taro', email: 'sample@sample.com', password: 'password')
      @user.save
    end

    it '保存できない' do
      expect(@user.errors.messages[:username][0]).to eq('はすでに存在します')
    end
  end

  context 'Eメールが他のユーザーと一緒だった場合' do
    let!(:user) { create(:user, email: 'sample@sample.com') }

    before do
      @user = User.new(username: 'taro', email: 'sample@sample.com', password: 'password')
      @user.save
    end

    it '保存できない' do
      expect(@user.errors.messages[:email][0]).to eq('はすでに存在します')
    end
  end

end
