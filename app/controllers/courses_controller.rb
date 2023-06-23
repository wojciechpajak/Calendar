class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course = Course.find(params[:id])
    authorize! :read, @course # sprawdza uprawnienia do czytania kursu
  end

  # GET /courses/new
  def new
    @course = Course.new
    @available_lecturers = available_lecturers
  end

  # GET /courses/1/edit
  def edit
    if current_user.admin? || current_user.username == @course.lecturer
      # Możesz umieścić kod dotyczący edycji kursu tutaj
    else
      redirect_to courses_url, notice: "You are not authorized to perform this action."
    end
  end
  

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    
    if current_user.admin?
      lecturer_username = params[:course][:lecturer]
      lecturer = User.find_by(username: lecturer_username, role: :lecturer)
      @course.lecturer = lecturer.username if lecturer
    else
      @course.lecturer = current_user.username
    end
  
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if current_user.admin?
      lecturer_username = params[:course][:lecturer]
      lecturer = User.find_by(username: lecturer_username, role: :lecturer)
      @course.lecturer = lecturer.username if lecturer
    else
      @course.lecturer = current_user.username
    end

    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course = Course.find(params[:id])
  
    if current_user.admin?
      @course.destroy
      redirect_to courses_url, notice: "Course was successfully destroyed."
    elsif current_user.username == @course.lecturer
      @course.destroy
      redirect_to courses_url, notice: "Course was successfully destroyed."
    else
      redirect_to courses_url, alert: "You are not authorized to perform this action."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :location, :lecturer, :start_time, :end_time)
    end

    def available_lecturers
      User.pluck(:username)
    end
end
