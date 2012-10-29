require 'test_helper'

class PostTest < ActiveSupport::TestCase

  fixtures :posts, :comments

  # Test the increment vote count function
  def test_voting
    post = posts(:one)
    comment = comments(:one)
    post.increment_votes(comment.id)
    assert_equal 1, comment.votes
  end

end
