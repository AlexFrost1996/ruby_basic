class PassengerCarriage < Carriage
  def initialize(number_carriage, volume)
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
    errors = []
    errors << "Place must be integer number" if volume.class != Integer
    super(errors)
  end
end