class ExerciseTwoController < ApplicationController
  @@solution = []

  def show
    @solution = @@solution
  end

  def create
    @@solution = ExerciseTwoService.new.call(params[:input_file])
    redirect_to :exercise_two
  end
end
