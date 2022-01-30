class Robot
  attr_accessor :x_coord, :y_coord, :face_direction, :name, :active

  def initialize(xval, yval, direction)
    @x_coord = xval
    @y_coord = yval
    @face_direction = direction
    @name = nil
    @active = true
  end

  def active?
    @active
  end

  def deactivate
    @active = false
  end
end
