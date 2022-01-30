class View
  def invalid_move_text
    puts 'The Robot will fall off if it moves this way! - Please change direction first'
  end

  def report(robots)
    # TODO: loop through robots array
    active_robot = nil
    robots.each do |robot|
      puts "#{robot.name}: #{robot.x_coord},#{robot.y_coord},#{robot.face_direction.capitalize}"
      # check which is active and puts this information.
      active_robot = robot if robot.active?
    end
    puts "#{active_robot.name} is currently active"
  end
end
