require 'rails_helper'

RSpec.describe 'output', type: :system do
  let!(:user) { create(:user) }
  let!(:finish_task) { create(:task, completed: 'true',  user: user) }

  before do
    sign_in user
  end

  context '既に学びが登録してある場合' do
    let!(:output) { create(:output, task: finish_task, user: user) }

    it '学びが表示される' do
      visit finish_tasks_path
      find('.finish-box').click
      expect(page).to have_css('.output-content', text: output.content)
      expect(page).to have_css('.output-book-title', text: finish_task.title)
    end

    it '学びが編集できる', js: true do
      visit finish_tasks_path
      find('.finish-box').click
      find('.output-edit-box').click
      find('.d-menu').click
      fill_in 'output_content', with: 'アウトプットのテストです'
      find('.my-btn').click
      expect(page).to have_css('.output-content', text: 'アウトプットのテストです')
    end

    it 'タスク一覧に戻ることができる' do
      visit task_outputs_path(task_id: finish_task.id)
      find('.task-link-box').click
      expect(page).to have_css('.book-title', text: finish_task.title)
    end
  end

  context 'まだ学びを登録していない場合' do
    it '登録ができる' do
      visit finish_tasks_path
      find('.finish-box').click
      fill_in 'output_content', with: 'アウトプットを作成テスト'
      find('.my-btn').click
      expect(page).to have_css('.output-content', text: 'アウトプットを作成テスト')
    end 
  end
  
  
end