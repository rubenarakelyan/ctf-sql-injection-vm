require 'sinatra'
require 'active_record'
require_relative 'config/database'

# Logged in as "Administrator"
set :user_id, 1

class Notes < Sinatra::Application
  get '/' do
    if params[:filter]
      sql = "select #{params[:filter]} from notes where user_id = #{settings.user_id}"
      @notes = ActiveRecord::Base.connection.exec_query(sql)
    else
      @notes = Note.where(user_id: settings.user_id).all
    end

    erb :index
  end

  get '/note/add' do
    erb :add_note
  end

  post '/note/add' do
    begin
      @note = Note.new(
        title: params[:title],
        body: params[:body],
        user_id: settings.user_id
      )
      @note.save!
      redirect '/'
    rescue ActiveRecord::RecordInvalid => e
      @errors = e
      erb :add_note
    end
  end

  get '/note/:id/edit' do
    @note = Note
            .where(user_id: settings.user_id)
            .find(params[:id]) || halt(404)
    erb :edit_note
  end

  put '/note/:id/edit' do
    begin
      @note = Note
              .where(user_id: settings.user_id)
              .find(params[:id]) || halt(404)
      @note.update!(
        title: params[:title],
        body: params[:body]
      )
      redirect '/'
    rescue ActiveRecord::RecordInvalid => e
      @errors = e
      erb :edit_note
    end
  end

  get '/note/:id/delete' do
    @note = Note
            .where(user_id: settings.user_id)
            .find(params[:id]) || halt(404)
    erb :delete_note
  end

  delete '/note/:id/delete' do
    @note = Note
            .where(user_id: settings.user_id)
            .find(params[:id]) || halt(404)
    @note.delete
    redirect '/'
  end
end

# Show nice 404 pages
not_found do
  erb :not_found
end
