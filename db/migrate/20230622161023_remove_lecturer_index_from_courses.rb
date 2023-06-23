class RemoveLecturerIndexFromCourses < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :lecturer_index
  end
end

