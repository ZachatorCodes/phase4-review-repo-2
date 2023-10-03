class MoviesController < ApplicationController
    skip_before_action :authorize, only: [:index, :word_search, :genrecount]

    def index 
        movies = Movie.all
        render json: movies 
    end

    def show 
        movie = Movie.find_by(id: params[:id])
        render json: movie
    end

    def create 
        movie = Movie.create(movie_params)
        render json: movie, status: :created
    end

    def update 
        movie = Movie.find(params[:id])
        movie.update!(movie_params)
        render json: movie, status: 202
    end

    def destroy 
        movie = Movie.find(params[:id])
        movie.destroy 
        head :no_content
    end

    def genrecount
        movies = Movie.all
        results = {}

        genres = movies.map do |movie|
            movie.genre
        end

        # Solution 1
        genre_tally = genres.tally

        #Solution 2
        genres.each do |genre|
            if results.has_key?(genre)
                results[genre] += 1
            else
                results[genre] = 1
            end
        end

        render json: results
    end

 
    private 

    def movie_params
        params.permit(:title, :genre, :year, :director, :image_url)
    end

end
