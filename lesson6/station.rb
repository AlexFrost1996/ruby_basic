class Station
  include InstanceCounter, Validate
  attr_reader :trains, :name 
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  private

  def validate!
    errors = []
    errors << "Name can't be nil!" if name.nil?
    errors << "Name must be a symbol!" if name.class != Symbol
    errors << "Name length must be at least 3" if name.to_s.length < 3
    raise errors.join(". ") unless errors.empty?
  end
end
