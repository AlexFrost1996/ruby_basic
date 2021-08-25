# frozen_string_literal: true

class Route
  attr_accessor :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    station.delete(station)
  end

  def view_route
    stations.each { |station| puts station.name }
  end
end
