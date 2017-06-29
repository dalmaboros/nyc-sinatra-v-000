class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  # CREATE
  get '/landmarks/new' do
    @landmarks = Landmark.all
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save
    redirect to "/landmarks/#{@landmark.id}"
  end

  # READ
  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/show'
  end

  # UPDATE
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/edit'
  end

  post '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    if params[:landmark][:name] != @landmark.name
      @landmark.name = params[:landmark][:name]
      @landmark.save
    end
    if params[:landmark][:year_completed] != @landmark.year_completed
      @landmark.year_completed = params[:landmark][:year_completed]
      @landmark.save
    end
    redirect to "/landmarks/#{@landmark.id}"
  end

end
