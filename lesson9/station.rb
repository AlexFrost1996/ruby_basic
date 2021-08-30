# frozen_string_literal: true

class Station
  include Accessors
  include Validation
  include InstanceCounter
  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :length, 3
  validate :name, :type, Symbol

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def each_train(&block)
    trains.each(&block)
  end
end
