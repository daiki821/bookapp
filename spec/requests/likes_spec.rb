require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let!(:user) { create(:user) }
  let!(:recommend) { create(:recommend, user: user) }
  

  describe 'GET /recommends/:recommend_id/like' do
    context 'いいねしている場合' do
      let!(:like) { create(:like, recommend: recommend, user: user) }
      before do
        sign_in user
      end
      it '200ステータスとtrueが返ってくる' do
        get recommend_like_path(recommend_id: recommend.id)
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        like_status = JSON.parse(response.body)['hasLiked']
        expect(like_status).to eq true
      end
    end

    context 'いいねしていない場合' do
      before do
        sign_in user
      end

      it '200ステータスとfalseが返ってくる' do
        get recommend_like_path(recommend_id: recommend.id)
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        like_status = JSON.parse(response.body)['hasLiked']
        expect(like_status).to eq false
      end
    end
  end

  describe 'POST /recommends/:recommend_id/like' do
    before do
      sign_in user
    end
    it 'いいねを保存できる' do
      post recommend_like_path(recommend_id: recommend.id)
      expect(response).to have_http_status(200)
      like_status = JSON.parse(response.body)['status']
      expect(like_status).to eq 'ok'
    end
  end

  describe 'DELETE /recommends/:recommend_id/like' do
    let!(:like) { create(:like, user: user, recommend: recommend) }
    before do
      sign_in user
    end
    it 'いいねが削除できる' do
      post recommend_like_path(recommend_id: recommend.id)
      expect(response).to have_http_status(200)
      like_status = JSON.parse(response.body)['status']
      expect(like_status).to eq 'ok'
    end
  end

end
