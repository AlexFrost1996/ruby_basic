# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
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

  # The user will be able to change the station list without resorting to the corresponding method
  attr_writer :stations
end
