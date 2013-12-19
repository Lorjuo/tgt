require "test_helper"

class NavigateToHomeTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert_content page, "Turngemeinde 1879 Traisa e.V."
    refute_content page, "Goobye All!"
  end
end
