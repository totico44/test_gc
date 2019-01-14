class ExerciseOneController < ApplicationController
  @@solution = []

  def show
    @solution = @@solution
  end

  def create
    @@solution = ExerciseOneService.new.call(params[:input_file])
    redirect_to :exercise_one
  end
end
