class ExerciseThreeService
  def call(input_file)
    result = []
    file = File.open(input_file.path)
    lines = file.readlines
    next_case = true
    line_index = 0
    while next_case do
      ant_quantity = 0
      street_longitude = 0
      anthenas = []
      removing_anthenas_quantity = 0
      
      #Aqui se lee la información para cada caso
      formated_line = lines[line_index].strip
      if formated_line == "-1"
        next_case = false
      else
        first_data = formated_line.split(",")
        street_longitude = first_data[0].to_i
        ant_quantity = first_data[1].to_i
        line_index += 1
        
        ant_quantity.times do |x|
          formated_line = lines[line_index].strip.split(",")
          anthenas << {location: formated_line[0].to_i, ratio: formated_line[1].to_i, removed: false}
          line_index += 1
        end
        
        #Aqui realizamos la lógica del problema
        covered_points = []
        anthenas_to_points = []
      
        #Convertimos los datos de cada entena (radio y localizacón) en un array con los puntos de covertura de cada una
        anthenas.each do |anthena, index|
          anthena_to_points = [anthena[:location]]
          anthena[:ratio].times do |x|
            anthena_to_points.insert(0,anthena[:location] - (x+1)) if (anthena[:location] - (x+1)) >= 0
            anthena_to_points << (anthena[:location] + (x+1)) if (anthena[:location] + (x+1)) <= street_longitude
          end
          anthenas_to_points << anthena_to_points
        end 
        
        #Empezamos a revisar los puntos de covertura de todas las antenas
        anthenas.each_with_index do |anthena, index|
          if anthena[:ratio] == 0
            removing_anthenas_quantity += 1
            anthena[:removed] = true
          else
            if (covered_points & anthenas_to_points[index]).length == anthenas_to_points[index].length
              removing_anthenas_quantity += 1
              anthena[:removed] = true
            else
              if index >=2
                (index+1).times do |x|
                  if !anthenas[x][:removed]
                    set1 = []
                    set2 = []
                    (index+1).times do |y| 
                      if anthenas[y][:removed] == false
                        set1 = set1 | anthenas_to_points[y]  
                        set2 = set2 | anthenas_to_points[y] unless (x==y) 
                      end
                    end
                    set1 = set1.sort
                    set2 = set2.sort
                    if set1 == set2 &&
                      removing_anthenas_quantity += 1
                      anthenas[x][:removed] = true
                    end
                  end
                end
              end
            end
          end
          covered_points = covered_points | anthenas_to_points[index]
        end
        
        #Impimimos el resultado
        if covered_points.length == street_longitude+ 1
          result << removing_anthenas_quantity
        else
          result << -1
        end
      end
    end
    file.close
    result
  end
end