class Router
  def initialize(controller)
    @controller = controller
    @multiple_robots = false
  end

  # Begins the game
  def play
    puts 'Where will you place the Robot?'
    first_choice = gets.chomp.downcase

    @controller.place(place_input(first_choice)[0], place_input(first_choice)[1], place_input(first_choice)[2])

    loop do
      puts 'What do you want to do next?'
      if @multiple_robots
        puts 'Robot X | PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT'
        choice = gets.chomp.downcase
        router_action_multiple_robots(choice)
      else
        puts 'PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT'
        choice = gets.chomp.downcase
        router_action(choice)
      end
    end
  end

  def router_action(action)
    case action
    when 'move' then @controller.move
    when 'left' then @controller.left
    when 'right' then @controller.right
    when 'report' then puts @controller.status
    when check then @controller.place(place_input(action)[0], place_input(action)[1], place_input(action)[2])
      @multiple_robots = true
    else
      puts 'Wrong input, try again...'
    end
  end

  def router_action_multiple_robots(action)
    case action
    when /robot [0-9]+/i then @controller.change_active_robot(action)
    when 'move' then @controller.move
    when 'left' then @controller.left
    when 'right' then @controller.right
    when 'report' then puts @controller.status
    when check then @controller.place(place_input(action)[0], place_input(action)[1], place_input(action)[2])
    else
      puts 'Wrong input, try again...'
    end
  end

  # check if input has correct form
  def check
    /place [0-4],[0-4],(north|east|south|west)/i
  end

  # call place method with correct arguments
  def place_input(input)
    first_coord = input.match(/(?<=place )[0-4]/).to_s.to_i
    second_coord = input.match(/(?<=place [0-4],)[0-4]/).to_s.to_i
    direction = input.match(/(?<=place [0-4],[0-4],)(north|east|south|west)/i).to_s
    [first_coord, second_coord, direction]
  end
end
