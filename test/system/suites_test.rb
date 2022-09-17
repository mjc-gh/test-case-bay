require "application_system_test_case"

class SuitesTest < ApplicationSystemTestCase
  setup do
    @suite = suites(:one)
  end

  test "visiting the index" do
    visit suites_url
    assert_selector "h1", text: "Suites"
  end

  test "should create suite" do
    visit suites_url
    click_on "New suite"

    fill_in "Description", with: @suite.description
    fill_in "Title", with: @suite.title
    click_on "Create Suite"

    assert_text "Suite was successfully created"
    click_on "Back"
  end

  test "should update Suite" do
    visit suite_url(@suite)
    click_on "Edit this suite", match: :first

    fill_in "Description", with: @suite.description
    fill_in "Title", with: @suite.title
    click_on "Update Suite"

    assert_text "Suite was successfully updated"
    click_on "Back"
  end

  test "should destroy Suite" do
    visit suite_url(@suite)
    click_on "Destroy this suite", match: :first

    assert_text "Suite was successfully destroyed"
  end
end
