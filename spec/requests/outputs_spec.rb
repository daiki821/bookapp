require 'rails_helper'

RSpec.describe 'Outputs', type: :request do
  let!(:user) { create(:user) }
  let(:task) { create(:task, user: user) }
  let!(:output) { create(:output, user: user, task: task)}
  describe 'GET /tasks/:task_id/outputs' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '200ステータスが返ってくる' do
        get task_outputs_path(task_id: task)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページに遷移する' do
        get task_outputs_path(task_id: task)
        expect(response).to redirect_to user_session_path
      end
    end

  end

  

  describe 'PUT /tasks/:task_id/outputs' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '保存できる' do
        output_params = attributes_for(:output)
        put task_outputs_path({task_id: task ,output: output_params})
        expect(response).to have_http_status(302)
        expect(Output.last.content).to eq(output_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移' do
        output_params = attributes_for(:output)
        put task_outputs_path({task_id: task ,output: output_params})
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
