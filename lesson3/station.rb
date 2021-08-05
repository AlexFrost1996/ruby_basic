=begin
Класс Станция (Station)
1) Имеет название, которое указывается при ее создании 

2) Может принимать поезда (по одному за раз)

3) Может возвращать список всех поездов на станции, находящиеся в текущий момент

4) Может возвращать список поездов на станции по типу: кол-во грузовых, пассажирских

5) Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов,
находящихся на станции).
=end

class Station
  attr_reader :trains, :name 
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def train_by_type(type)
    trains.each{|train| train.type == type}.size
  end
end
