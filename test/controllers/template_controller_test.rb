require 'test_helper'

class TemplateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get template_index_url
    assert_response :success
  end

end
