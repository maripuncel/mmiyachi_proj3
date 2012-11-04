require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :comments, :admins, :posts

  # test if comment can be created
  def test_create
    post = posts(:one)
    comment = comments(:one)
    new_comment = post.comments.create(:author => comment.author)
    assert_equal comment.author, new_comment.author
  end

  # test setting the priority of comments
  def test_priority
    post = posts(:one)
    comment = post.comments.create(:author => "Mari")
    comment.set_priority
    assert_equal 1, comment.priority
  end
end
