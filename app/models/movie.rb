class Movie < ActiveRecord::Base

  def self.get_all_ratings
    Movie.pluck(:rating).uniq
  end

  def self.with_ratings(rating_list)
    byebug
  end

end