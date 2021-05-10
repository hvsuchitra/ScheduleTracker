class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    #Examing params and session hash
    update_session_hash
    render_or_redirect 
    determine_highlighting
    #set instance variables for views
    @all_ratings = Movie.all_ratings
    #session[:ratings] = params[:ratings] || all_hash
    @selected_ratings =selected_ratings
    @selected_ratings_hash = selected_ratings_hash
    #@movies = Moie.fil
    @sort = sort
   # determine_highlighting
    @movies =Movie.filter_and_sort(@selected_ratings, @sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  def selected_ratings
    session[:ratings]&.keys
  end
  
  def all_hash
    Hash[Movie.all_ratings.map{|rating| [rating,"1"]}]
  end
  
  def selected_ratings_hash
    session[:ratings]
  
  end
  
  def sort
    #params[:sort] || "id"
   session[:sort] || "id"
  end

  def determine_highlighting
    @header_hilite = {:title=>"" ,:release_date=>"",:id =>""}
    @header_hilite[sort] ="bg-warning hilite"
  end
  
  
  def update_session_hash
     session[:ratings] = params[:ratings] || session[:ratings] || all_hash
     session[:sort] = params[:sort] || session[:sort] || "id"
  end  
  
  def render_or_redirect
    return unless (session[:ratings] and params[:ratings].nil?) or 
                  (session[:sort] and params[:sort].nil?) 
  flash.keep
  redirect_to movies_path(:ratings=>session[:ratings],:sort=>session[:sort])
  end
end 

