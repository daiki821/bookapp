require 'rails_helper'

RSpec.describe Task, type: :model do

  let!(:user) { create(:user) }

  context 'タイトルと締め切り日が入力されている場合' do
    let!(:task) { build(:task, user: user) }

    it 'タスクが保存できる' do
      expect(task).to be_valid
    end

  end

  context 'タイトルが未入力の場合' do
    let!(:task) { build(:task, title: '', user: user) }

    before do 
      task.save
    end

    it '保存できない' do
      expect(task.errors.messages[:title][0]).to eq('を入力してください')
    end
  end

  context '締め切り日が未入力だった場合' do
    let!(:task) { build(:task, completed_at: '', user: user) }

    before do
      task.save
    end

    it '保存できない' do
      expect(task.errors.messages[:completed_at][0]).to eq('を入力してください')
    end
  end

  context '締め切り日が過去の日付だった場合' do
    let!(:task) { build(:task, completed_at: '2001-03-22', user: user )}

    before do 
      task.save
    end

    it '保存できない' do
      expect(task.errors.messages[:completed_at][0]).to eq(': 過去の日付は登録できません')
    end
  end
  
end
