require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sonyislife"
  end

  get "/" do
    erb :welcome
  end

  get "/login" do
    erb :"/user/login"
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/welcome"
    else
      redirect to "/login"
    end
  end

  get "/signup" do
    erb :"/user/signup"
  end

  post "/signup" do
    user = User.new(username: params[:username], password: params[:password], gear: params[:gear])
    if User.find_by(username: user.username).nil? && user.save 
      session[:user_id] = user.id
      redirect "/welcome"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/welcome" do
    erb :welcome
  end



  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/signup"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
