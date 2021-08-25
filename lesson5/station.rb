# frozen_string_literal: true

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
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
