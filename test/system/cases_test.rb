require "application_system_test_case"

class CasesTest < ApplicationSystemTestCase
  setup do
    @case = cases(:one)
  end

  test "visiting the index" do
    visit cases_url
    assert_selector "h1", text: "Cases"
  end

  test "should create case" do
    visit cases_url
    click_on "New case"

    fill_in "Acceptance criteria", with: @case.acceptance_criteria
    fill_in "Details", with: @case.details
    fill_in "Title", with: @case.title
    click_on "Create Case"

    assert_text "Case was successfully created"
    click_on "Back"
  end

  test "should update Case" do
    visit case_url(@case)
    click_on "Edit this case", match: :first

    fill_in "Acceptance criteria", with: @case.acceptance_criteria
    fill_in "Details", with: @case.details
    fill_in "Title", with: @case.title
    click_on "Update Case"

    assert_text "Case was successfully updated"
    click_on "Back"
  end

  test "should destroy Case" do
    visit case_url(@case)
    click_on "Destroy this case", match: :first

    assert_text "Case was successfully destroyed"
  end
end
