require 'test_helper'

class S3filesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get s3files_new_url
    assert_response :success
  end

  test "should get index" do
    get s3files_index_url
    assert_response :success
  end

  test "should get show" do
    get s3files_show_url
    assert_response :success
  end

end
