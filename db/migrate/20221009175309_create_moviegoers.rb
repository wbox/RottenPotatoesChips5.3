class CreateMoviegoers < ActiveRecord::Migration
  def change
    create_table :moviegoers do |t|
      t.text 'username'
      t.references 'reviews'
    end
  end
end
