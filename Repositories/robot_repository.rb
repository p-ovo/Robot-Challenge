class RobotRepository
  attr_accessor :robots, :active_robot

  def initialize
    @next_id = 1
    @robots = []
    @active_robot = nil
  end

  def add(robot)
    robot.name = "Robot #{@next_id}"
    @robots << robot
    deactivate_robot
    @next_id += 1
    @active_robot = robot
  end

  def deactivate_robot
    @active_robot.deactivate unless @active_robot == nil
  end

  def activate(robot)
    robot.active = true
  end

  def find_by_name(name)
    @robots.each do |robot|
      return robot if robot.name == name
    end
  end
end
