class Post < ActiveRecord::Base
  attr_accessible :admin_id, :name, :url
  belongs_to :admin
  has_many :comments

  # Increment votes for a comment on a post
  # Input: comment ID
  # Output: updated comment with new vote count
  def increment_votes(comment_id)
    if @comment = Comment.find_by_id(comment_id)
      @new_votes = @comment.votes + 1
      @comment.update_attributes(votes: @new_votes)
    end
  end
end
