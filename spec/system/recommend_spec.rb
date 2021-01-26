require 'rails_helper'

RSpec.describe 'Recommend', type: :system do
  let!(:user) { create(:user) }
  let!(:recommends) { create_list(:recommend, 3, user:user) }

  before do
    sign_in user
  end
  describe 'recommend index' do

    it '全部の記事が表示される' do 
      visit recommends_path
      recommends.each do |recommend| 
        expect(page).to have_css('.recommend-title', text: recommend.title)
        expect(page).to have_css('.recommend-content', text: recommend.content)
      end
    end
  
    it '記事の詳細ページに行くことができる' do
      visit recommends_path
      click_on recommends.first.title
      expect(page).to have_css('.recommend-title', text: recommends.first.title)
      expect(page).to have_css('.recommend-content', text: recommends.first.content)
    end
  
    it '記事が投稿できる' do
      visit recommends_path
      find('.create-recommend-btn').click
      fill_in 'タイトル', with: 'テスト'
      fill_in 'おすすめしたい内容', with: 'テストテストテストテストテストテスト'
      find('.my-btn').click
      expect(page.first('.recommend-title').text).to eq 'テスト'
      expect(page.first('.recommend-content').text).to eq 'テストテストテストテストテストテスト'
      expect(page).to have_css('.notice', text: '保存できました')
    end
  
    it '記事が削除できる', js: true do
      visit recommends_path
      first('.recommend-edit-box').click
      page.accept_confirm do
        find('.d-menu').click_on
      end
      expect(page).to have_css('.notice', text: '削除しました')
      expect(page).to_not have_css('.recommend-title', text: recommends.last.title)
    end

  end
  

  describe 'recommend show' do

    let!(:recommend) { create(:recommend, user: user) }

    it '記事が削除できる', js: true do
      visit recommend_path(id: recommend.id)
      find('.recommend-edit-box').click
      page.accept_confirm do
        find('.d-menu').click_link
      end
      expect(page).to have_css('.notice', text: '削除しました')
      expect(page).to_not have_css('.recommend-title', text: recommend.title)
    end

    context 'いいねをしていない場合' do
      it 'いいねを表示するこができる', js: true do
        visit recommend_path(id: recommend.id)
        find('.like-btn-box').click
        expect(page).to have_css('.active-heart')
        expect(page).to_not have_css('.heart')
        expect(page).to have_css('.like-count', text: '1')
      end
    end
    
    context 'いいねをしている場合' do
      let!(:like) { create(:like, recommend: recommend, user: user) }

      it 'いいねを解除する' do
        visit recommend_path(id: recommend.id)
        find('.like-btn-box').click
        expect(page).to have_css('.heart')
        expect(page).to_not have_css('.active-heart')
        expect(page).to have_css('.like-count', text: '0')
      end

    end

    context 'コメントがある場合' do
      let!(:comments) { create_list(:comment, 3, recommend: recommend, user: user) }

      it 'コメントが表示される' do
        visit recommend_path(id: recommend.id)
        comments.each do |comment|
          expect(page).to have_css('.comment-username', text: comment.user.username)
          expect(page).to have_css('.comment-content-box', text: comment.content)
        end
      end
    end

    it 'コメントを投稿できる', js: true do
      visit recommend_path(id: recommend.id)
      find('.comment-btn').click
      fill_in 'comment_content', with: 'コメントテスト'
      find('.add-comment-btn').click
      expect(page).to have_css('.comment-content-box', text: 'コメントテスト')
    end

    it 'コメントを削除できる' do
      visit recommend_path(id: recommend.id)
      first('.comment-edit-box').click
      find('.d-menu').click
      expect(page).to_not have_css('.comment-content-box', text: comments.first.content)
    end
   
  end
  

  
 
end
