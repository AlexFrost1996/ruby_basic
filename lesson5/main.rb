require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriages.rb'

MENU = [
  {index: 1, title: "create new station", action: :create_new_station},
  {index: 2, title: "create new train", action: :create_new_train},
  {index: 3, title: "create new route and manage on it", action: :create_new_route},
  {index: 4, title: "set route for train", action: :set_route_for_train},
  {index: 5, title: "add carriages to the train", action: :add_carriages_to_train},
  {index: 6, title: "remove carriages from the train", action: :remove_carriages_from_train},
  {index: 7, title: "move train on the route", action: :move_train_on_route},
  {index: 8, title: "view the list of stations and the list of trains at the station", action: :view_station_and_trains}
]

def create_new_station
  puts "Enter name of new Class station: "
  name_class_station = gets.chomp

  puts "Enter name of the new station: "
  name_station = gets.chomp.to_sym

  name_class_station = Station.new(name_station)
  puts name_class_station
end

def create_new_train
  puts "Enter name of new class train: "
  name_class_train = gets.chomp

  puts "Enter name of the new train: "
  name_train = gets.chomp.to_sym

  puts "Enter type of the new train: "
  type_train = gets.chomp.to_sym

  if type_train == :passenger
    name_class_train = PassengerTrain.new(name_train)
    puts name_class_train
    
  elsif type_train == :cargo
    name_class_train = CargoTrain.new(name_train)
    puts name_class_train

  else
    puts "Error!"
  end
end

def create_new_route
  puts "Enter 'new' for create new route"
  puts "Enter 'manage' for manage the station on route"
  user_choise = gets.chomp.to_sym

  if user_choise == :new
    puts "Enter name new class route"
    name_class_route = gets.chomp
    puts "Enter first station on route"
    first_station = gets.chomp.to_sym
    puts "Enter last station on roune"
    last_station = gets.chomp.to_sym
    name_class_route = Route.new(first_station, last_station)
    puts name_class_route

  elsif user_choise == :manage
    puts "Enter 'add' for add station on route"
    puts "Enter 'delete' for delete station on route"
    user_choise = gets.chomp.to_sym

    if user_choise == :add
      puts "Enter name class new station on route"
      name_class_station = gets.chomp
      puts "Enter route for add station"
      changed_route = gets.chomp
      changed_route.add_station(name_class_station)

    elsif user_choise == :delete
      puts "Enter name class station for delete"
      name_class_station = gets.chomp
      puts "Enter route for delete station on it"
      changed_route = gets.chomp
      changed_route.delete_station(name_class_station)

    else
      puts "Error!"
    end
  end
end  

def set_route_for_train
  puts "Enter name class train for set route"
  name_class_train = gets.chomp
  puts "Entere name class route for this train"
  route_for_set = gets.chomp
  name_class_train.set_route(route_for_set)
end

def add_carriages_to_train
  puts "Enter name class train for add carriages"
  name_class_train = gets.chomp
  puts "Enter name class carriages for add to train"
  name_class_carriages = gets.chomp
  name_class_train.add_carriages(name_class_carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless name_class_train.type_train == name_class_carriages.type
end

def remove_carriages_from_train
  puts "Enter name class train for remove carriages"
  name_class_train = gets.chomp
  puts "Enter name class carriages for remove from train"
  name_class_carriages = gets.chomp
  name_class_train.remove_carriages(name_class_carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless name_class_train.type_train == name_class_carriages.type
end

def move_train_on_route
  puts "Enter 'forward' for move to next station"
  puts "Enter 'back' for move to previous station"
  user_choise = gets.chomp.to_sym

  if user_choise == :forward
    puts "Enter name class train for move to next station"
    name_class_train = gets.chomp
    name_class_train.move_forward
    
  elsif user_choise == :back
    puts "Enter name class train for move to previous station"
    name_class_train = gets.chomp
    name_class_train.move_back
    
  else
    puts "Error!"
  end
end

def view_station_and_trains
  puts "Enter name class route for view list station"
  name_class_route = gets.chomp
  name_class_route.view_route
  puts "Enter name class station for view list train on it"
  name_class_station = gets.chomp
  name_class_station.trains
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
