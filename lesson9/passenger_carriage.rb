# frozen_string_literal: true

class PassengerCarriage < Carriage
  def initialize(number_carriage, volume)
    super
    @type = :passenger
  end

  def take_place
    raise 'No vacant place' if free_volume.zero?

    self.occupied_volume += 1 if free_volume.positive?
  end
end
