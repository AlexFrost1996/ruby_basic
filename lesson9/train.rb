# frozen_string_literal: true

class Train
  include Accessors
  include Validation
  include InstanceCounter
  include Manufacturer
  attr_reader :number, :carriages, :route, :carriage_number
  attr_accessor :speed

  @@trains = []

  NUMBER_TRAIN_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/.freeze

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_TRAIN_FORMAT

  def self.find(number)
    @@trains.each { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    validate!
    @@trains << self
    register_instance
  end

  def stop
    self.speed = 0
  end

  def set_route(route)
    self.route = route
    self.route.stations[0].take_train(self)
    @current_station_index = 0
  end

  def add_carriage(carriage)
    carriages << carriage if speed.zero? && type == carriage.type
  end

  def remove_carriage(carriage)
    carriages.delete(carriage) if speed.zero? && type == carriage.type
  end

  def current_station
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

  def each_carriage(&block)
    carriages.each(&block)
  end

  protected

  attr_writer :route
end
