require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
<<<<<<< HEAD
=======

  should have_many(:assignments)
  should have_many(:roles).through(:assignments)

  test "user should have role" do
  assert_not(@subject.role? :admin)
 
  @subject.roles << Role.new(name: "admin")
 
  assert(@subject.role? :admin)
end
>>>>>>> f76ffd52b579afa948ebecdf93edaa51ee39b8f5
end
