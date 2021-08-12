class Station
  include InstanceCounter
  attr_reader :trains, :name 
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  private

  def validate!
    raise "Name can't be nil!" if name.nil?
    raise "Name must be a symbol!" if name.class != Symbol
    raise "Name length must be at least 3" if name.length < 3
  end
end
