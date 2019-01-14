class ExerciseOneService
  def call(input_file)
    file = File.open(input_file.path)
    lines = file.readlines
    counter = lines[0].strip.to_i
    result = []
    count = 0
    index = 2
    #1. Aqui comienza el primer gran ciclo que se repite n veces como indica la primera linea
    counter.times do |x|
      wait = []
      while count == 0 do
        formated_line = lines[index].strip.to_i
        wait << {init: formated_line, position: formated_line, parked: false} unless formated_line == 99
        count = 1 if formated_line == 99
        index += 1
      end
      count = 0
      while count == 0 do
        formated_line = lines[index].strip.to_i
        min_dist = 30
        parking_car = {}
        position = 0
        if formated_line != 99
          out_car = formated_line
          #Buscando la distancia mas corta del carro esperando al carro que sale
          wait.each do |waiting_car|
            if !waiting_car[:parked]
              if waiting_car[:position] <= out_car
                dist = out_car - waiting_car[:position]
              else
                dist = (out_car+20) - waiting_car[:position]
              end
              if dist < min_dist
                min_dist = dist
                #Aqui queda guardado el carro que se parquea
                parking_car = waiting_car
                #Aqui queda guardado la posicion en que queda el carro que se parquea
                position = (((waiting_car[:position] + min_dist) % 20) == 0) ? 20 : (waiting_car[:position] + min_dist) % 20
              end
            end
          end
          ######################################################
          #Parqueando el carro
          parking_car[:position] = position
          parking_car[:parked] = true
          ######################################################
          #moviendo los otros carros
          wait.each do |moving_car|
            if !moving_car[:parked]
              relative_position = (moving_car[:position] + min_dist) % 20
              moving_car[:position] = relative_position == 0 ? 20 : relative_position
            end
          end
          ######################################################
        else
          count = 1
        end
        index += 1
      end
      result << wait
      count = 0
    end
    #1. Aqui termina el primer gran ciclo
    file.close
    result
  end
end