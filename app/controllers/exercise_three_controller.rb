class ExerciseThreeController < ApplicationController
  @@solution = []

  def show
    @solution = @@solution
  end

  def create
    @@solution = ExerciseThreeService.new.call(params[:input_file])
    redirect_to :exercise_three
  end
end
