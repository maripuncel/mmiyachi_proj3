require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  fixtures :admins

  # Test ability to create an admin
  def test_new_admin
    admin = Admin.create(name: admins(:one).name,
                        email: admins(:one).email,
                        password: "Test12",
                        password_confirmation: "Test12")

    admin_copy = Admin.find_by_name(admin.name)
    assert_equal admin.name, admin_copy.name
  end

end
