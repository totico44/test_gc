module ApplicationHelper
  
  def get_problem1_answer(x)
    end_of_line = x[:parked] ? "se parqueó en la posición #{x[:position]}" : "no se parqueó"
    str = "El auto de posición inicial #{x[:init]} " + end_of_line
  end
end
