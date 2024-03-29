require "application_system_test_case"

class HolesTest < ApplicationSystemTestCase
  setup do
    @hole = holes(:one)
  end

  test "visiting the index" do
    visit holes_url
    assert_selector "h1", text: "Holes"
  end

  test "should create hole" do
    visit holes_url
    click_on "New hole"

    fill_in "Number", with: @hole.number
    fill_in "Round", with: @hole.round_id
    fill_in "Score", with: @hole.score
    click_on "Create Hole"

    assert_text "Hole was successfully created"
    click_on "Back"
  end

  test "should update Hole" do
    visit hole_url(@hole)
    click_on "Edit this hole", match: :first

    fill_in "Number", with: @hole.number
    fill_in "Round", with: @hole.round_id
    fill_in "Score", with: @hole.score
    click_on "Update Hole"

    assert_text "Hole was successfully updated"
    click_on "Back"
  end

  test "should destroy Hole" do
    visit hole_url(@hole)
    click_on "Destroy this hole", match: :first

    assert_text "Hole was successfully destroyed"
  end
end
