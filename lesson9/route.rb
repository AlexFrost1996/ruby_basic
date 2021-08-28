# frozen_string_literal: true

class Route
  include Accessors
  include Validation
  include InstanceCounter
  attr_reader :stations

  validate :first, :type, Station
  validate :last, :type, Station

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    @first = start_station
    @last = finish_station
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def view_route
    stations.each { |station| puts station.name }
  end

  private

  attr_writer :stations
end
