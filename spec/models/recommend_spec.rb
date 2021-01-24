require 'rails_helper'

RSpec.describe Recommend, type: :model do
  let!(:user) { create(:user) }

  context 'タイトルと内容がある場合' do
    let!(:recommend) { build(:recommend, user: user) }

    it 'おすすめを保存できる' do
      expect(recommend).to be_valid
    end
  end

  context 'タイトルがない場合' do
    let!(:recommend) { build(:recommend, title: '', user: user) }

    before do
      recommend.save
    end

    it '保存できない' do
      expect(recommend.errors.messages[:title][0]).to eq('を入力してください')
    end
  end

  context '内容がない場合' do
    let!(:recommend) { build(:recommend, content: '', user: user) }

    before do
      recommend.save
    end

    it '保存できない' do
      expect(recommend.errors.messages[:content][0]).to eq('を入力してください')
    end

  end

  context '内容が200文字以上の場合' do
    let!(:recommend) { build(:recommend, content: Faker::Lorem.characters(number: 201), user: user) }

    before do
      recommend.save
    end

    it '保存できない' do
      expect(recommend.errors.messages[:content][0]).to eq('は200文字以内で入力してください')
    end
  end

end
