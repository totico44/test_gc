class ExerciseTwoService
  def call(input_file)
    result = []
    line_index = 0
    next_game = false
    
    shoots = []
    number_of_players = 0
    snakes_and_stairs = []
    players = []
    special_positions = []
    
    file = File.open(input_file.path)
    lines = file.readlines
    
    
      # Aqui se leen los lanzamienros a utilizar en todos los juegos
      while shoots.last != 0 do
        formated_line = lines[line_index].strip
        shoots.concat formated_line.split(" ").map(&:to_i)
        line_index += 1
      end
    
    while !next_game do
      #Aqui se lee la cantidad de jugadores y se inicializan los jugadores
      number_of_players = lines[line_index].strip.to_i
      number_of_players.times do |player|
        players << {position: 0, can_shoot: true, priority: player}
      end
      line_index += 1
    
      #Aqui se lee las escaleras y serpientes
      condition = 0
      while condition == 0 do
        arr_formated_line = lines[line_index].strip.split(*" ").map(&:to_i)
        if arr_formated_line[0] == 0 && arr_formated_line[1] == 0
          condition = 1
        else
          snakes_and_stairs << {start: arr_formated_line[0], end: arr_formated_line[1]} 
        end
        line_index += 1
      end
    
      #Aqui se leen las ganadas o pérdida de turnos
      condition = 0
      while condition == 0 do
        formated_line = lines[line_index].strip.to_i
        if formated_line != 0
          special_positions << formated_line
        else
          condition = 1
        end
        line_index += 1
      end
    
      #Aqui comienza el juego
      turn_index = 0
      continue_playing = true
      shoot_index = 0
    
      while continue_playing do
        #Aqui verificamos si el jugador en turno puede hacer el movimiento
        next_shoot = false
        while !next_shoot do
          player_turn = turn_index % players.length
          if players[player_turn][:can_shoot]
            next_shoot = true
            #Aqui se verifica si la posición final sobrepasa el No. 100 y se avanza si no es asi
            if players[player_turn][:position] + shoots[shoot_index] <= 100
              players[player_turn][:position] = players[player_turn][:position] + shoots[shoot_index]

              #Aqui verificamos si el jugador en turno cayó en alguna casilla con escalera o serpiente
              snake_or_stair = snakes_and_stairs.select{|x| x[:start]== players[player_turn][:position]}.first
              players[player_turn][:position] = snake_or_stair.present? ? snake_or_stair[:end] : players[player_turn][:position]

              #Aqui verificamos si el jugador en turno cayó en alguna casilla especial
              count = 0
              while count < special_positions.length do
                  if special_positions[count].abs == players[player_turn][:position]
                    if special_positions[count] < 0
                      players[player_turn][:can_shoot] = false
                    else
                      players.each_with_index do |player, index|
                        if index != count
                          player[:can_shoot] = false
                        end
                      end
                    end
                    count = 100
                  end
                  count += 1
              end

              if players[player_turn][:position] == 100
                result << "#{players[player_turn][:priority] + 1}"
                continue_playing = false
              end
            
            end
          else
            players[player_turn][:can_shoot] = true
          end
          turn_index += 1
        end 
        shoot_index += 1
      end
      
      next_game = true if lines[line_index].strip.to_i == 0
      snakes_and_stairs.clear
      players.clear
      special_positions.clear
    end
    
    file.close
    result
  end
end