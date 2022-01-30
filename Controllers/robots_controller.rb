require_relative '../Models/robot'
require_relative '../Models/square'
require_relative '../Views/view'

class RobotsController
  def initialize(repository)
    @robot_repository = repository
    @view = View.new
  end

  def move
    # find active robot
    robot = @robot_repository.active_robot
    # move in the direction facing by 1
    # move 1 spot forward unless on edge of board
    case robot.face_direction
    when 'north'
      robot.y_coord != 4 ? robot.y_coord += 1 : @view.invalid_move_text
    when 'east'
      robot.x_coord != 4 ? robot.x_coord += 1 : @view.invalid_move_text
    when 'west'
      robot.x_coord != 0 ? (robot.x_coord -= 1) : @view.invalid_move_text
    when 'south'
      robot.y_coord != 0 ? robot.y_coord -= 1 : @view.invalid_move_text
    end
  end

  def place(xval, yval, direction)
    # place a new robot
    robot = Robot.new(xval, yval, direction)
    @robot_repository.add(robot)
  end

  def left
    # find active robot
    robot = @robot_repository.active_robot
    # rotate robot face 90deg anticlockwise
    case robot.face_direction
    when 'north'
      robot.face_direction = 'west'
    when 'east'
      robot.face_direction = 'north'
    when 'south'
      robot.face_direction = 'east'
    when 'west'
      robot.face_direction = 'south'
    end
  end

  def right
    # find active robot
    robot = @robot_repository.active_robot
    # rotate robot face 90deg clockwise
    case robot.face_direction
    when 'north'
      robot.face_direction = 'east'
    when 'east'
      robot.face_direction = 'south'
    when 'south'
      robot.face_direction = 'west'
    when 'west'
      robot.face_direction = 'north'
    end
  end

  def status
    @view.report(@robot_repository.robots)
  end

  def change_active_robot(action)
    # check if this robot exists
    if @robot_repository.robots.length >= action.match(/(?<=robot )[0-9]+/i).to_s.to_i
      # deactivate current active robot
      @robot_repository.deactivate_robot
      # activate robot in action
      robot_name = action.match(/robot [0-9]+/i).to_s.capitalize
      robot = @robot_repository.find_by_name(robot_name)
      @robot_repository.activate(robot)
    else
      puts "Wrong input, try again..."
    end
  end
end
