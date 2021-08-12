class Train
  include Manufacturer, InstanceCounter
  attr_reader :number, :carriages, :route
  attr_accessor :speed
  @@trains = []
  NUMBER_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/

  def self.find(number)
    @@trains.each{|train| train.number == number}
  end
  
  def initialize (number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains << self
    validate!
  end

  def stop
    self.speed = 0
  end

  def set_route(route)
    self.route = route
    self.route.stations[0].take_train(self)
    @current_station_index = 0
  end

  def add_carriages(carriage)
    carriages << carriage if speed.zero? && type == carriage.type
  end

  def remove_carriages(carriage)
    carriages.delete(carriage) if speed.zero? && type == carriage.type
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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  attr_writer :route

  def validate!
    raise "Number can't be nil" if number.nil?
    raise "Number should be at least 5 symbols" if number.length < 5
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end
