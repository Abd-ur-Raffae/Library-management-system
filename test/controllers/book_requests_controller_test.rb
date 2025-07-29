require "test_helper"

class BookRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get book_requests_show_url
    assert_response :success
  end

  test "should get new" do
    get book_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get book_requests_create_url
    assert_response :success
  end

  test "should get edit" do
    get book_requests_edit_url
    assert_response :success
  end

  test "should get update" do
    get book_requests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get book_requests_destroy_url
    assert_response :success
  end

  test "should get approve" do
    get book_requests_approve_url
    assert_response :success
  end

  test "should get reject" do
    get book_requests_reject_url
    assert_response :success
  end
end
