class API::V1::CoursesController < ApplicationController
  before_action :set_courses, only: [:index]
  before_action :set_course, only: %i[show destroy]
  before_action :create_course, only: [:create]

  def index
    render json: @courses
  end

  def show
    render json: @course
  end

  def create

    if @course.save
      render json: { message: 'Course successfully created' }, status: 201
    else
      render json: { message: 'Unable to create course' }, status: 400
    end
  end

  # def create
  #   @user = User.new(user_params)
  #   @user.attach_avatar

  #   if @user.save
  #     log_in @user
  #     redirect_to @user,
  #                 notice: "Welcome, #{@user.fullname}.
  #                         You are now part of the biggest community of recipe enthusiasts in the world!"
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # rescue StandardError
  #   redirect_to new_user_path, notice: 'This username already exists. Please Choose another one.'
  # end

  def destroy
    if @course
      @course.destroy
      render json: { message: 'Course successfully deleted' }, status: 204
    else
      render json: { message: 'Unable to delete course' }, status: 400
    end
  end
end

private

def set_courses
  @courses = Course.all
end

def set_course
  @course = Course.find(params[:id])
end

def create_course
  @course = Course.new(course_params)
end

def course_params
  params.require(:course).permit(:title, :description, :instructor, :duration, :image)
end
