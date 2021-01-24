require 'rails_helper'

RSpec.describe 'Recommends', type: :request do
  let!(:user) { create(:user) }
  let!(:recommends) { create_list(:recommend, 6, user: user) }
  let!(:recommend) { create(:recommend, user:user) }

  describe 'GET /recommends#index' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get recommends_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページに遷移' do
        get recommends_path
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe 'POST /recommend' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'おすすめが保存できる' do
        recommend_params = attributes_for(:recommend)
        post recommends_path({recommend: recommend_params})
        expect(response).to have_http_status(302)
        expect(Recommend.last.title).to eq(recommend_params[:title])
        expect(Recommend.last.content).to eq(recommend_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページに遷移する' do
        recommend_params = attributes_for(:recommend)
        post recommends_path({recommend: recommend_params})
        expect(response).to redirect_to user_session_path
      end
    end

  end

  describe 'DELETE /recommend' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'おすすめが削除できる' do
        delete recommend_path(id: recommend)
        expect(response).to have_http_status(302)
        expect(recommend.destroy).to eq(recommend)
      end

    end

    context 'ログインしていない場合' do
      it 'ログインページに遷移する' do
        delete recommend_path(id: recommend)
        expect(response).to redirect_to user_session_path
      end
    end
  end

end
