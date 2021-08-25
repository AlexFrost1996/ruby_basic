# frozen_string_literal: true

class Train
  attr_reader :number, :type, :carriages
  attr_accessor :speed, :route

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def add_carriages
    @carriages += 1 if speed.zero?
  end

  def remove_carriages
    @carriages -= 1 if speed.zero? && @carriages > 1
  end

  def set_route(route)
    self.route = route
    self.route.stations[0].take_train(self)
    @current_station_index = 0
  end

  def current_route
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def move_forward
    return unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @current_station_index += 1
  end

  def move_back
    return unless previous_station

    current_station.send_train(self)
    previous_station.take_train(self)
    @current_station_index -= 1
  end
end
