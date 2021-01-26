require 'rails_helper'

RSpec.describe Output, type: :model do
  let!(:user) { create(:user) }
  let!(:task) { build(:task, user: user) }

  context '内容が書いてある場合'do
    let!(:output) { build(:output, task: task, user: user) }

    it '学びが保存できる' do
      expect(output).to be_valid
    end
  end

  context '内容がない場合' do
    let!(:output) { build(:output, content: '', task: task, user: user) }

    before do
      output.save
    end

    it '保存できない' do
      expect(output.errors.messages[:content][0]).to eq('を入力してください')
    end
  end

  context '本自体がない場合' do
    let!(:output) { build(:output, user: user) }

    before do
      output.save
    end

    it '保存できない' do
      expect(output.errors.messages[:task][0]).to eq('を入力してください')
    end
  end

end
