require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validate.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriages.rb'

MENU = [
  {index: 1, title: "create new station", action: :create_new_station},
  {index: 2, title: "create new train", action: :create_new_train},
  {index: 3, title: "create new route and manage on it", action: :manage_route},
  {index: 4, title: "set route for train", action: :set_route_for_train},
  {index: 5, title: "add carriages to the train", action: :add_carriages_to_train},
  {index: 6, title: "remove carriages from the train", action: :remove_carriages_from_train},
  {index: 7, title: "move train on the route", action: :move_train_on_route},
  {index: 8, title: "view the list of stations and the list of trains at the station", action: :view_station_and_trains}
]

=begin
MENU_TRAIN = [
  {index: 1, title: "create passenger train", action: :create_passenger_train},
  {index: 2, title: "create cargo train", action: :create_cargo_train}
] 
=end

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
  puts "Enter name of new Class station: "
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
  puts "Enter name of new class train: "
  train = gets.chomp.to_sym

  begin
    puts "Enter 1 for create passenger train"
    puts "Enter 2 for create cargo train"
    choice = gets.chomp.to_i

    puts "Enter number of the new train: "
    number = gets.chomp.to_s

    if choice == 1
      train = PassengerTrain.new(number)
      puts "Created new train: #{train}" if train.valid?
      
    elsif choice == 2
      train = CargoTrain.new(number)
      puts "Created new train: #{train}" if train.valid?
  
    else
      puts "Error! Please, repeat enter!"
    end

  rescue RuntimeError => e
    puts "Invalid data for the train! Error(s): #{e}"
    puts "Repeat enter data for the train"
    retry
  end
end

def manage_route
  puts "Enter your choice"
  MENU_ROUTE.each{|item| puts "#{item[:index]}: #{item[:title]}"}
  choice = gets.chomp.to_i
  need_item = MENU_ROUTE.find{|item| item[:index] == choice}
  send(need_item[:action])
end  

def create_new_route
  puts "Enter name new class route"
  route = gets.chomp.to_sym
  puts "Enter first station on route"
  first_station = gets.chomp.to_sym
  puts "Enter last station on roune"
  last_station = gets.chomp.to_sym
  route = Route.new(first_station, last_station)
  puts route
end

def add_station
  puts "Enter name class new station on route"
  station = gets.chomp.to_sym
  puts "Enter route for add station"
  route = gets.chomp.to_sym
  route.add_station!(station)
end

def delete_station
  puts "Enter name class station for delete"
  station = gets.chomp.to_sym
  puts "Enter route for delete station on it"
  route = gets.chomp.to_sym
  route.delete_station!(station)
end

def set_route_for_train
  puts "Enter name class train for set route"
  train = gets.chomp.to_sym
  puts "Entere name class route for this train"
  route = gets.chomp.to_sym
  train.set_route(route)
end

def add_carriages_to_train
  puts "Enter name class train for add carriages"
  train = gets.chomp
  puts "Enter name class carriages for add to train"
  carriages = gets.chomp
  train.add_carriages(carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless train.type == carriages.type
end

def remove_carriages_from_train
  puts "Enter name class train for remove carriages"
  train = gets.chomp
  puts "Enter name class carriages for remove from train"
  carriages = gets.chomp
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
  puts "Enter name class train for move to next station"
  train = gets.chomp.to_sym
  train.move_forward
end

def move_train_back
  puts "Enter name class train for move to previous station"
  train = gets.chomp.to_sym
  train.move_back
end

def view_station_and_trains
  puts "Enter name class route for view list station"
  route = gets.chomp
  route.view_route
  puts "Enter name class station for view list train on it"
  station = gets.chomp
  station.trains
end

loop do
  puts "Enter your choice"
  MENU.each{|item| puts "#{item[:index]}: #{item[:title]}"}
  choice = gets.chomp.to_i
  need_item = MENU.find{|item| item[:index] == choice}
  send(need_item[:action])
  puts "Enter any key for continue or 'exit' for exit"
  break if gets.chomp.to_sym == :exit
end
