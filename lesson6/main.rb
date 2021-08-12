require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriages.rb'
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

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
  station = gets.chomp

  puts "Enter name of the new station: "
  name = gets.chomp.to_sym

  station = Station.new(name)
  puts station
end

def create_new_train
  puts "Enter name of new class train: "
  train = gets.chomp.to_sym

  begin
    puts "Enter number of the new train: "
    number = gets.chomp.to_s

    puts "Enter type of the new train: "
    type = gets.chomp.to_sym

    if type == :passenger
      train = PassengerTrain.new(number)
      puts "Created new train: #{train}"
      
    elsif type == :cargo
      train = CargoTrain.new(number)
      puts "Created new train: #{train}"
  
    else
      raise "Invalid type train!"
    end

  rescue RuntimeError => e
    puts "Invalid number train! Error: #{e}"
    puts "Repeat enter number or type of train"
    retry
  end
end

def create_new_route
  puts "Enter 'new' for create new route"
  puts "Enter 'manage' for manage the station on route"
  choise = gets.chomp.to_sym

  if choise == :new
    puts "Enter name new class route"
    route = gets.chomp
    puts "Enter first station on route"
    first_station = gets.chomp.to_sym
    puts "Enter last station on roune"
    last_station = gets.chomp.to_sym
    route = Route.new(first_station, last_station)
    puts route

  elsif choise == :manage
    puts "Enter 'add' for add station on route"
    puts "Enter 'delete' for delete station on route"
    choise = gets.chomp.to_sym

    if choise == :add
      puts "Enter name class new station on route"
      station = gets.chomp
      puts "Enter route for add station"
      route = gets.chomp
      route.add_station(station)

    elsif choise == :delete
      puts "Enter name class station for delete"
      station = gets.chomp
      puts "Enter route for delete station on it"
      route = gets.chomp
      route.delete_station(station)

    else
      puts "Error!"
    end
  end
end  

def set_route_for_train
  puts "Enter name class train for set route"
  train = gets.chomp
  puts "Entere name class route for this train"
  route = gets.chomp
  train.set_route(route)
end

def add_carriages_to_train
  puts "Enter name class train for add carriages"
  train = gets.chomp
  puts "Enter name class carriages for add to train"
  carriages = gets.chomp
  train.add_carriages(carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless train.type_train == carriages.type
end

def remove_carriages_from_train
  puts "Enter name class train for remove carriages"
  train = gets.chomp
  puts "Enter name class carriages for remove from train"
  carriages = gets.chomp
  train.remove_carriages(carriages)
  puts "Error, train not stop!" unless speed.zero?
  puts "Error of type carriages" unless train.type_train == carriages.type
end

def move_train_on_route
  puts "Enter 'forward' for move to next station"
  puts "Enter 'back' for move to previous station"
  choise = gets.chomp.to_sym

  if choise == :forward
    puts "Enter name class train for move to next station"
    train = gets.chomp
    train.move_forward
    
  elsif choise == :back
    puts "Enter name class train for move to previous station"
    train = gets.chomp
    train.move_back
    
  else
    puts "Error!"
  end
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
