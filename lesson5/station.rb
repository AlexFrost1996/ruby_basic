class Station
  include InstanceCounter
  attr_reader :trains, :name 
  @@object_station = []

  def self.all
    @@object_station
  end

  def initialize(name)
    @name = name
    @trains = []
    @@object_station << self
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
