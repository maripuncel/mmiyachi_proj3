class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :priority, :votes
  belongs_to :post

  # Sets priority bit to 1 if it was 0
  # or to 0 if it was 1
  def set_priority
    if self.priority == 1
      self.update_attributes(priority: 0)
    else self.update_attributes(priority: 1)
    end
  end

  # Returns string if comment is prioritized
  def is_priority
    if self.prioirity == 1
      return "Prioritized"
    else return ""
    end
  end
end
