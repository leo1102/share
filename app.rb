require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'
require './image_uploader.rb'

enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

get '/' do
    @title="トップ"
    @page_title="トップ"
    
    @contents = Contribution.order("created_at DESC")
        
    erb :index
end

get '/signin' do
    @title="ログイン"
    @page_title="ログイン"
    
    erb :sign_in
end    

get '/signup' do
    @title="アカウントを作成"
    @page_title="アカウントを作成"
    
    erb :sign_up
end

get '/new' do
    @title="画像を投稿　"
    @page_title="画像を投稿"
    
    erb :new
end

get '/usage' do
    @title="使い方"
    @page_title="使い方"
    
    erb :usage
end

get '/7808839' do
    @title="アカウント一覧"
    @page_title="アカウント一覧"
    
    @user = User.all
    
    erb :accounts
end

#ここより下はアクション

post '/signin' do
    user = User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
      session[:user] = user.id
    end
    
    redirect '/'
end    

post '/signup' do
    @user = User.create(
        familyname: params[:familyname], 
        firstname: params[:firstname], 
        familyname_phonetic: params[:familyname_phonetic], 
        firstname_phonetic: params[:firstname_phonetic],
        mail: params[:mail], 
        phone: params[:phone], 
        password: params[:password], 
        password_confirmation: params[:password_confirmation]
    )
    
    if @user.persisted?
        session[:user] = @user.id
    end
    
    redirect '/'
end

get '/signout' do
    session[:user] = nil
   
    redirect '/'
end

post '/new' do
    Contribution.create({
        name: params[:name],
        img: ""
    })
    if params[:file]
        image_upload(params[:file])
    end
    
    redirect '/'
end

post '/:id/delete' do
    user = User.find(params[:id])
    user.delete
    
    redirect '/7808839'
end
