require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let!(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 6, user: user)}
  let!(:task) { create(:task, user:user) }

  describe 'GET /todo_tasks' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get todo_tasks_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get todo_tasks_path
        expect(response).to redirect_to user_session_path
      end
    end

  end




  describe 'POST /task' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'タスクが保存できる' do
        task_params = attributes_for(:task)
        post tasks_path({task: task_params})
        expect(response).to have_http_status(302)
        expect(Task.last.title).to eq(task_params[:title])
        expect(Task.last.completed_at.to_s).to eq(task_params[:completed_at])
      end
    end

    context 'ログインしていない場合' do
      it 'タスクを保存できない' do
        task_params = attributes_for(:task)
        post tasks_path({task: task_params})
        expect(response).to redirect_to user_session_path
      end
    end

  end

  

  describe 'DELETE /task' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
  
      it 'タスクが削除できる' do
        delete task_path(id: task.id)
        expect(response).to have_http_status(302)
        expect(task.destroy!).to eq(task)
      end 
    end

    context 'ログインしていない場合' do
      before do
        @task = Task.create(id: '1100', title: 'aaaaa', completed_at: '2022-02-22', user: user)
      end
      it 'ログイン画面に遷移する' do
        delete task_path(id: @task.id)
        expect(response).to redirect_to user_session_path
      end
    end
  end

end
