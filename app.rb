require_relative 'router'
require_relative 'Controllers/robots_controller'
require_relative 'Repositories/robot_repository'

robot_repository = RobotRepository.new
robots_controller = RobotsController.new(robot_repository)

router = Router.new(robots_controller)
router.play
