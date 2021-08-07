station1 = Station.new(:london)
station2 = Station.new(:wales)
station3 = Station.new(:liverpool)
station4 = Station.new(:winchester)

route1 = Route.new(station1, station4)
route2 = Route.new(station2, station3)

train1 = Train.new("758BV")
train2 = PassengerTrain.new("125F")
train3 = PassengerTrain.new("671CB")
train4 = CargoTrain.new("666S")

carriage1 = Carriages.new(:cargo)
carriage2 = Carriages.new(:passenger)
carriage3 = Carriages.new(:passenger)
carriage4 = Carriages.new(:cargo)
carriage5 = Carriages.new(:cargo)
