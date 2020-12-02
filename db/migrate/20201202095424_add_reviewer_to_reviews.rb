class AddReviewerToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :reviewer, foreign_key: { to_table: :users }
  end
end
