require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:john)
  end

  test 'should create valid user' do
    assert @user.valid?
  end

  test "should not save blank user" do
    user = User.new
    assert_not user.save
  end

  test "should not save user without name" do
    @user.name = nil
    refute @user.valid?, "Saved user without a name"
    assert_not_nil @user.errors[:name]
  end

  test "user name length must be greater than one" do
    @user.name = "J"
    assert_not @user.valid?, "Saved user with a name too short"
  end

  test "should not save user without email" do
    @user.email = nil
    refute @user.valid? "Saved user without an email"
    assert_not_nil @user.errors[:email]
  end

  test "should not save user without password" do
    @user.password = nil
    refute @user.valid? "Saved user without a password"
    assert_not_nil @user.errors[:password]
  end

  test '#geolocations' do
    assert_equal 2, @user.geolocations.size
  end

end
