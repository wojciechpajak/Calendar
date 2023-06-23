require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "should create course" do
    visit courses_url
    click_on "New course"

    fill_in "End time", with: @course.end_time
    fill_in "Lecturer", with: @course.lecturer
    fill_in "Lecturer index", with: @course.lecturer_index
    fill_in "Location", with: @course.location
    fill_in "Start time", with: @course.start_time
    fill_in "Title", with: @course.title
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "should update Course" do
    visit course_url(@course)
    click_on "Edit this course", match: :first

    fill_in "End time", with: @course.end_time
    fill_in "Lecturer", with: @course.lecturer
    fill_in "Lecturer index", with: @course.lecturer_index
    fill_in "Location", with: @course.location
    fill_in "Start time", with: @course.start_time
    fill_in "Title", with: @course.title
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "should destroy Course" do
    visit course_url(@course)
    click_on "Destroy this course", match: :first

    assert_text "Course was successfully destroyed"
  end
end
