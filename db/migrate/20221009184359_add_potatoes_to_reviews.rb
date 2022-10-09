class AddPotatoesToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :potatoes, :integer
  end
end
