class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      
      if Title.find_by(id: params[:figure][:title_ids])
          @figure.titles << Title.find_by(id: params[:figure][:title_ids])
      else
        @figure.titles << Title.create(params[:title])
      end
    end

    if !params[:landmark][:name].empty?
      # @figure.landmarks << Landmark.find_by(id: params[:figure][:landmark_ids])
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"

  end

  get '/figures/:figure_id' do
    @figure = Figure.find_by(id: params[:figure_id])
    erb :'/figures/show'
  end

  get '/figures/:figure_id/edit' do
    @figure = Figure.find_by(id: params[:figure_id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch '/figures/:figure_id' do 
    @figure = Figure.find_by(id: params[:figure_id])

    if !params[:figure][:name].empty?
      @figure.name = params[:figure][:name]
    end

    
    if !params[:Title].empty?
      @figure.titles << params[:Title]
    end

    if !params[:figure][:landmark_ids].empty?
      @landmark = Landmark.find_by(id: params[:figure][:landmark_ids])
      @figure.landmarks << @landmark
    end

    if !params["Landmark Name"].empty?
      @landmark = Landmark.find_or_create_by(name: params["Landmark Name"])
      @figure.landmarks << @landmark
    end


    @figure.save
    erb :'figures/show'
  end






end
