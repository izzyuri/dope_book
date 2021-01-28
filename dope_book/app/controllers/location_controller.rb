class LocationController < ApplicationController

    get '/locations' do
        redirect_if_not_logged_in
        @locations = current_user.locations
        erb :"Locations/index"
    end

    get '/locations/new' do
        redirect_if_not_logged_in
        erb :"Locations/new"
    end

    post '/locations/new' do
        redirect_if_not_logged_in
        location = Location.new(address: params[:address])
        location.save
        current_user.locations << location
        current_user.save 
        redirect "/locations/#{location.id}"
    end

    get '/locations/:id/edit' do
        redirect_if_not_logged_in
        @location = Location.find_by(id: params[:id])
        if current_user.locations.include?(@location)
            erb :'Locations/edit'
        else
            redirect '/welcome'
        end
    end

    get '/locations/:id' do
        redirect_if_not_logged_in
        @location = Location.find_by(id: params[:id])
        if current_user.locations.include?(@location)
            erb :'Locations/show'
        else
            redirect '/welcome'
        end
    end

    patch '/locations/:id' do
        redirect_if_not_logged_in
        @location = Location.find_by(id: params[:id])
        @location.address = params[:address]
        @location.save
        redirect "/locations/#{@location.id}"
    end

    delete '/locations/:id' do
        redirect_if_not_logged_in
        @location = Location.find_by(id: params[:id])
        @location.destroy
        redirect "/locations"
    end
end
