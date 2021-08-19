class PassengerCarriages < Carriages
  def initialize(number_carriages, volume)
    super
    @type = :passenger
    validate!
  end

  def take_place!
    raise "No vacant place" if free_volume.zero?
    self.occupied_volume += 1 if free_volume > 0
  end

  private

  def validate!
    super
    errors << "Place must be integer number" if volume.class != Integer
  end
end