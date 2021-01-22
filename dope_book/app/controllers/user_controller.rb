class UserController < ApplicationController

    get '/users/:id' do
        redirect_if_not_logged_in

        @user = User.find_by(id: params[:id])
        if !@user.nil? && @user == current_user
            erb :'users/show'
        else
            redirect '/locations'
        end
    end

    patch '/users/:id' do
        user = User.find_by(id: params[:id])
        if !params[:gear].empty?
            user.gear = params[:gear]
        end
        user.save
        redirect "/users/#{user.id}"
    end

    delete '/users/:id' do
        current_user.destroy
        redirect "/logout"
    end
end   