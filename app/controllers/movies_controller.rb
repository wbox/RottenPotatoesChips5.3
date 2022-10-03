class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index

      # Part 1
      # If no rating present in the params, set @ratings_to_show with all
      # ratings available from the movies records in the database

      # If ratings present in the params, set @ratings_to_show with the
      # ratings present in the parameters only
      
      # Part 2
      # Create two global variables to define if the column background is yellow or not.
      # Add with_ratings to the sql query for title and release date links
     
      @all_ratings = Movie.all_ratings
      
      if params[:ratings].present?
        @ratings_to_show = params[:ratings].keys
      else
        @ratings_to_show = Movie.all_ratings
      end
      
      unless params[:movie_title].present? and params[:release_date_title].present? 
        @movies = Movie.with_ratings(@ratings_to_show)
      end
      
      if params[:movie_title].present?
        @movie_title = 'hilite bg-warning'
        @movies = Movie.with_ratings(@ratings_to_show).order(:title)
      else
        @hilite_bg = ''
      end

      if params[:release_date_title].present?
        @release_date_title = 'hilite bg-warning'
        @movies = Movie.with_ratings(@ratings_to_show).order(:release_date)
      else
        @release_date_title = ''
      end

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
  end