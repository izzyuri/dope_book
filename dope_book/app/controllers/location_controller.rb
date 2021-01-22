class LocationController < ApplicationController

    get '/locations' do
        redirect_if_not_logged_in
        @locations = Location.all
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
        redirect "/locations/#{location.id}"
    end

    get '/locations/:id/edit' do
        redirect_if_not_logged_in
        @location = Location.find(params[:id])
        erb :'Locations/edit'
    end

    get '/locations/:id' do
        redirect_if_not_logged_in
        @location = Location.find(params[:id])
        erb :'Locations/show'
    end

    patch '/locations/:id' do
        redirect_if_not_logged_in
        @location = Location.find(params[:id])
        @location.address = params[:address]
        @location.save
        redirect "/locations/#{@location.id}"
    end

    delete '/locations/:id' do
        redirect_if_not_logged_in
        @location = location.find(params[:id])
        redirect "/locations"
    end
end
