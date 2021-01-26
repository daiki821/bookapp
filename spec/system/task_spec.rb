require 'rails_helper'

RSpec.describe 'Task', type: :system  do
  let!(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 2, user: user) }
  let!(:finish_tasks) {create_list(:task, 2, completed: 'true', user: user) }
  context 'ログインしている場合' do
    before do
      sign_in user
    end
    it 'タスクの一覧ページが表示される' do
      visit root_path
      tasks.each do |task| 
        expect(page).to have_css('.book-title', text: task.title)
        expect(page).to have_css('.task-finish-btn', text: '完了')
      end
    end

    it 'タスクの完了ページが表示される' do
      visit root_path
      find('.click-link').click
      finish_tasks.each do |task|
        expect(page).to have_css('.book-title', text: task.title)
        expect(page).to have_css('.task-finish-btn', text: '学び')
      end
    end

    it 'タスクを保存できる' do
      visit root_path
      find('.create-btn').click
      fill_in 'タイトル', with: 'ガガガががが'
      fill_in '締め切り日', with: '2021-01-30'
      find('.my-btn').click
      expect(page).to have_css('.book-title', text: 'ガガガががが')
      expect(page).to have_css('.notice', text: '保存できました')
    end

    it '完了ボタンを押したら完了する' do
      visit root_path
      first_title = first('.book-title').text
      first('.task-finish-btn').click
      expect(page).to_not have_css('.book-title', text: first_title)
      visit finish_tasks_path
      expect(page).to have_css('.book-title', text: first_title)
    end

    it 'タスクの編集ができる', js: true do
      visit root_path
      first('.edit-icon-box').click
      first('.d-menu').click
      fill_in 'タイトル', with: 'テストテストテスト'
      fill_in '締め切り日', with: '002022-04-17'
      find('.btn.btn-light.my-btn').click
      expect(page).to have_css('.book-title', text: 'テストテストテスト')
      expect(page).to have_css('.book-completed_at', text: '2022年04月17日(日)')
      expect(page).to have_css('.notice', text: '更新できました')
    end

    it 'タスクが削除できる', js: true do
      visit root_path
      first_title = first('.book-title').text
      first('.edit-icon-box').click
      page.accept_confirm do
        all('.d-menu')[1].click
      end
      expect(page).to have_css('.notice', text: '削除しました')
      expect(page).not_to have_css('.book-title', text: first_title)
    end

    

  end
end
