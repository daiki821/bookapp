require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:recommend) { create(:recommend, user: user) }
  let!(:comments) { create_list(:comment, 2, user: user, recommend: recommend) }
  describe 'GET /recommends/:recommend_id/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get recommend_comments_path(recommend_id: recommend.id)
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        json_comments = body['data']
        expect(json_comments.length).to eq 2
        expect(json_comments[0]['attributes']['content']).to eq comments.first.content
        expect(json_comments[1]['attributes']['content']).to eq comments.last.content
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページに遷移する' do
        get recommend_comments_path(recommend_id: recommend.id)
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe 'POST /recommends/:recommend_id/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      
      it '保存できる' do
        comment_params = attributes_for(:comment)
        post recommend_comments_path({recommend_id: recommend.id, comment: comment_params})
        content = JSON.parse(response.body)['data']['attributes']['content']
        expect(content).to eq comment_params[:content]
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページに遷移する' do
        comment_params = attributes_for(:comment)
        post recommend_comments_path({recommend_id: recommend.id, comment: comment_params})
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe 'DELETE /recommends/:recommend_id/comments/:id' do
    let!(:comment) { create(:comment, user: user, recommend: recommend) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '削除できる' do
        delete recommend_comment_path(recommend_id: recommend.id, id: comment.id)
        comment_status = JSON.parse(response.body)['status']
        expect(comment_status).to eq 'ok'
      end
    end

    context 'ログインしていない場合'do
      it 'ログイン画面に遷移する' do
        delete recommend_comment_path(recommend_id: recommend.id, id: comment.id)
        expect(response).to redirect_to user_session_path
      end
    end
  end


end
