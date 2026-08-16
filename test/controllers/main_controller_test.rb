require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "updates a record and redirects to its token URL" do
    record = records(:one)

    patch update_main_path(token: record.access_token), params: { goal: "更新した目標" }

    assert_redirected_to edit_main_path(token: record.access_token)
    assert_equal "更新した目標", record.reload.data["goal"]
  end
end
