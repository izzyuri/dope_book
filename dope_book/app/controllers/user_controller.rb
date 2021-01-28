class UserController < ApplicationController

    get '/users/edit' do
        erb :'user/edit'
    end

    patch '/users/:id/edit' do
        user = User.find_by(id: params[:id])
        if !params[:gear].empty?
            user.gear = params[:gear]
        end
        user.save
        redirect "/welcome"
    end

    delete '/users/:id' do
        current_user.destroy
        redirect "/logout"
    end
end   