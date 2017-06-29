class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  # CREATE
  get '/figures/new' do
    @figures = Figure.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.find_or_create_by(name: params[:figure][:name])
    # @song = @artist.songs.build(name: params[:song][:name])
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        @title = Title.find_by(id: title_id)
        @figure.titles << @title
        @figure.save
      end
    end
    if params[:title][:name] != ""
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.titles << @title
      @figure.save
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        @landmark = Landmark.find_by(id: landmark_id)
        @figure.landmarks << @landmark
        @figure.save
      end
    end
    if params[:landmark][:name] != ""
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << @landmark
      @figure.save
    end
    # @title = Title.find_by(id: params[:figure][:title_ids])
    # @song.genres << @genre
    @figure.save
    # flash[:message] = "Successfully created song."
    redirect to "/figures/#{@figure.id}"
  end

  # READ
  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/show'
  end

  # UPDATE
  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_or_create_by(id: params[:id])
    if params[:figure][:name] != @figure.name
      @figure.name = params[:figure][:name]
      @figure.save
    end
    if params[:landmark][:name] != ""
      @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      @figure.landmarks << @landmark
      @figure.save
    end

    redirect to "/figures/#{@figure.id}"
  end

end
