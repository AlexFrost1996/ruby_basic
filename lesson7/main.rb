require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validate.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'cargo_carriage.rb'

NUMBER_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/

MENU = [
  {index: 1, title: "create new station", action: :create_new_station},
  {index: 2, title: "create new train", action: :create_new_train},
  {index: 3, title: "create new carriage", action: :create_new_carriage},  
  {index: 4, title: "create new route and manage on it", action: :manage_route},
  {index: 5, title: "set route for train", action: :set_route_for_train},
  {index: 6, title: "add carriages to the train", action: :add_carriages_to_train},
  {index: 7, title: "remove carriages from the train", action: :remove_carriages_from_train},
  {index: 8, title: "move train on the route", action: :move_train_on_route},
  {index: 9, title: "show stations and trains at the station", action: :show_station_and_trains},
  {index: 10, title: "show train and carriages on train", action: :show_train_and_carriages},
  {index: 11, title: "take place in carriage", action: :take_place},
  {index: 12, title: "occupy volume in carriage", action: :occupy_volume}
]

MENU_ROUTE = [
  {index: 1, title: "create new route", action: :create_new_route},
  {index: 2, title: "add station on route", action: :add_station},
  {index: 3, title: "delete station on route", action: :delete_station}
]

MENU_MOVE_TRAIN = [
  {index: 1, title: "move train or route to next station", action: :move_train_forward},
  {index: 2, title: "move train on route to previous station", action: :move_train_back}
]

def create_new_station
  puts "Enter name of new object class station: "
  station = gets.chomp.to_sym

  begin
    puts "Enter name of the new station: "
    name = gets.chomp.to_sym
    station = Station.new(name)
  
    puts "Created new station #{station}" if station.valid?

  rescue RuntimeError => e
    puts "Invalid data for the station! Error(s): #{e}"
    puts "Repeat enter data for the station"
    retry
  end
end

def create_new_train
  puts "Enter name of new object class train:"
  train = gets.chomp.to_sym
  type = get_type
  number = get_number
  create_train(train, type, number)
end

def get_type
  puts "Enter 1 for create passenger [train/carriage]"
  puts "Enter 2 for create cargo [train/carriage]"
  choise = gets.chomp.to_i
  return choise
  raise "Invalid enter! Please, repeat!" unless ((choise == 1) ^ (choise == 2))
rescue RuntimeError => e
  puts e
  retry
end

def get_number
  puts "Enter number of the new train"
  number = gets.chomp.to_s
  return number
  raise "Invalid number! Please, repeat!" if number !~ NUMBER_FORMAT
rescue RuntimeError => e
  puts e
  retry
end

def create_train(train, type, number)
  case type
  when 1
    train = PassengerTrain.new(number)
  when 2
    train = CargoTrain.new(number)
  end
  puts "Created new train: #{train}"
end

def create_new_carriage
  puts "Enter name of new object class carriage:"
  carriage = gets.chomp.to_sym
  type = get_type
  number = get_number_carriage
  volume = get_volume(type)
  create_carriage(carriage, type, number, volume)
end

def get_number_carriage
  puts "Enter number of the new carriage"
  number = gets.chomp.to_s
  return number
  raise "Invalid number! Please, repeat!" if number !~ /^[a-z\d][a-z\d]*$/i
rescue RuntimeError => e
  puts e
  retry
end

def get_volume(type)
  case type
  when 1
    begin
      puts "Please enter number place"
      volume = gets.chomp.to_i
      raise "Invalid number place" if volume < 1
    rescue RuntimeError => e
      puts e
      retry
    end
    volume
  when 2
    begin
      puts "Please enter volume"
      volume = gets.chomp.to_f
      raise "Invalid volume" if volume <= 0
    rescue RuntimeError => e
      puts e
      retry
    end
    volume
  end
end

def create_carriage(carriage, type, number, volume)
  case type
  when 1
    carriage = PassengerCarriages.new(number, volume)
  when 2
    carriage = CargoCarriages.new(number, volume)
  end
  puts "Created new carriage: #{carriage}"
end

def take_place
  puts "Enter name of object class carriages for take place"
  carriage = gets.chomp.to_sym
  carriage.take_place!
end

def occupy_volume
  puts "Enter name of object class carriages for occupy volume"
  carriage = gets.chomp.to_sym
  puts "Enter volume for occupy"
  volume = gets.chomp.to_f
  carriage.occupy_volume!(volume)
end

def manage_route
  puts "Enter your choice"
  MENU_ROUTE.each{|item| puts "#{item[:index]}: #{item[:title]}"}
  choice = gets.chomp.to_i
  need_item = MENU_ROUTE.find{|item| item[:index] == choice}
  send(need_item[:action])
end  

def create_new_route
  puts "Enter name new object class route"
  route = gets.chomp.to_sym
  puts "Enter first station on route"
  first_station = gets.chomp.to_sym
  puts "Enter last station on roune"
  last_station = gets.chomp.to_sym
  route = Route.new(first_station, last_station)
  puts route
end

def add_station
  puts "Enter name of object class new station on route"
  station = gets.chomp.to_sym
  puts "Enter route for add station"
  route = gets.chomp.to_sym
  route.add_station!(station)
end

def delete_station
  puts "Enter name of object class station for delete"
  station = gets.chomp.to_sym
  puts "Enter route for delete station on it"
  route = gets.chomp.to_sym
  route.delete_station!(station)
end

def set_route_for_train
  puts "Enter name of object class train for set route"
  train = gets.chomp.to_sym
  puts "Entere name of object class route for this train"
  route = gets.chomp.to_sym
  train.set_route(route)
end

def add_carriages_to_train
  puts "Enter name of object class train for add carriages"
  train = gets.chomp.to_sym
  puts "Enter name of object class carriages for add to train"
  carriages = gets.chomp.to_sym
  train.add_carriages(carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless train.type == carriages.type
end

def remove_carriages_from_train
  puts "Enter name of object class train for remove carriages"
  train = gets.chomp.to_sym
  puts "Enter name of object class carriages for remove from train"
  carriages = gets.chomp.to_sym
  train.remove_carriages(carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless train.type == carriages.type
end

def move_train_on_route
  puts "Enter your choice"
  MENU_MOVE_TRAIN.each{|item| puts "#{item[:index]}: #{item[:title]}"}
  choice = gets.chomp.to_i
  need_item = MENU_MOVE_TRAIN.find{|item| item[:index] == choice}
  send(need_item[:action])
end

def move_train_forward
  puts "Enter name of object class train for move to next station"
  train = gets.chomp.to_sym
  train.move_forward
end

def move_train_back
  puts "Enter name of object class train for move to previous station"
  train = gets.chomp.to_sym
  train.move_back
end

def show_station_and_trains
  station = select_from_collection(stations)
  puts "Trains on station #{station}:"
  station.each_train {|train| puts "Number train: #{train.number}, type train: #{train.type}, carriages: #{train.carriages.size}" }
end

def show_train_and_carriages
  train = select_from_collection(trains)
  puts "Carriages on train #{train}:"
  train.each_carriage do |carriage| 
    puts "Number carriage: #{carriage.number_carriages}, type carriage: #{carriage.type},
    free place(volume): #{carriage.free_volume}, occupied place(volume): #{carriage.occupied_volume}"
  end
end

loop do
  puts "Enter your choice"
  MENU.each{|item| puts "#{item[:index]}: #{item[:title]}"}
  choice = gets.chomp.to_i
  need_item = MENU.find{|item| item[:index] == choice}
  send(need_item[:action])
  puts "Enter any key for continue or '0' for exit"
  break unless gets.chomp.to_i.zero?
end
