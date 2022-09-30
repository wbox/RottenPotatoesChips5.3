class Movie < ActiveRecord::Base

  def self.all_ratings
    Movie.pluck(:rating).uniq
  end

  def self.with_ratings(rating_list)
    Movie.where(:rating => rating_list)
  end

end