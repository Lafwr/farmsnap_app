require "test_helper"

class CratesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get crates_index_url
    assert_response :success
  end

  test "should get show" do
    get crates_show_url
    assert_response :success
  end

  test "should get new" do
    get crates_new_url
    assert_response :success
  end

  test "should get edit" do
    get crates_edit_url
    assert_response :success
  end

  test "should get all" do
    get crates_all_url
    assert_response :success
  end
end
