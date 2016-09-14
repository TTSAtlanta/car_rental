require_relative "vehicle"
require_relative "person"

@lot = []
@people = []
@rented_cars = {}

def print_menu clear, *msg
	if clear == true
		system "clear"
	end
	
  puts "*************************************************"
	puts "****  Welcome to the Car Rental Application  ****"
  puts "*************************************************"

	puts "**** Please select from the following menu: ***"
	puts "**** 1. Add a Vehicle to inventory"
	puts "**** 2. List Vehicles"
  puts "**** 3. Add a Customer"
  puts "**** 4. List Customers"
  puts "**** 5. Rent a Car"
  puts "**** 4. List Rented Cars"
	puts "**** 9. Exit program"

	if !msg.empty?
	  print_message(msg)
	end 

	choice = gets.chomp.to_i

	if choice == 1
		create_a_vehicle
	elsif choice == 2 
		list_vehicles
	elsif choice == 3
		create_a_person
	elsif choice == 4
		list_people
	elsif choice == 5
		rent_a_car		
	elsif choice == 6
		list_rented_cars
	elsif choice == 9
		exit_application				
	else
		puts "You need to enter a valid selection, dummy"
		print_menu(true)
	end
end

def print_message msg
	puts "!!! #{msg} !!!!" 
end

def create_a_vehicle
	puts "Enter a year (e.g. 2012):"
	year = gets.chomp.to_i
	puts "Enter a make (e.g. Honda) :"
	make = gets.chomp
	puts "Enter a model: (e.g. Accord)"
	model = gets.chomp

	rental_car = Vehicle.new(year, make, model)

	@lot.push(rental_car)

	print_menu(true, "The #{rental_car.year} #{rental_car.make} #{rental_car.model} was added!")
end

def create_a_person
	puts "Enter the person's name: "
	name = gets.chomp
	puts "Enter the person's age: "
	age = gets.chomp
	puts "Enter the person's city: "
	city = gets.chomp

	renter = Person.new(name, age, city)

	@people.push(renter)

	print_menu(true, "#{renter.name} was added!")
end

def exit_application
	puts "**** Thank you for using the TTS Car Rental application.  See you later ****"
end

def list_vehicles
	puts "The cars you have entered so far are: "
	@lot.each_with_index do |car, index|
		puts "#{index+1}. #{car.year} #{car.make} #{car.model}"
	end
	print_menu(false)
end

def list_people
	puts "Customer List: "
	@people.each_with_index do |person, index|
		puts "#{index+1}. Name:#{person.name}   Age:#{person.age}   City:#{person.city}"
	end
	print_menu(false)
end

def rent_a_car
  # The first thing we want to do is list the people available who can rent a car
  # You'll notice that this code is identical to the list_people method.  What does that
  # tell you? That there is opportunity here to DRY out the code.  
  puts "Please select a customer: "
  @people.each_with_index do |person, index|
		puts "#{index+1}. Name:#{person.name}   Age:#{person.age}   City:#{person.city}"
	end
   
	person_choice = gets.chomp.to_i
  
  # Same thing as above we list the cars available for rent.  Again, identical code from list_vehicles
	puts "Please select a car: "
	@lot.each_with_index do |car, index|
		puts "#{index+1}. #{car.year} #{car.make} #{car.model}"
	end

	car_choice = gets.chomp.to_i

  # So here is the special sauce.  This is where a renter gets assigned to a car.  We are using
  # the rented_cars hash to do it.  The key, will be the car, and the value will be the person. 
  # This may seem a bit confusing, but break it down by parts.  
  # Let's simplify this example and say that @lot has one car. Like so...
  # @lot = ["Toyota"]
  # Since this is zero indexed, the Toyota is index 0. 
  # So, @lot[0] = "Toyota", right? 
  # Using the same principle, is how we assign the key and value.  
  # The reason for the subtracting of 1 is because to list out the names, I used the index. 
  # However a list that starts with zero, like this...
  # 0. 
  # 1. 
  # 2. 
  # ...looks totally retarded so I add one.  I need to subtract 1 to get the correct index. 

  @rented_cars[@lot[car_choice-1]] = @people[person_choice-1]
	
	print_menu(true, "Added!")
end

def list_rented_cars
	puts "Cars that are rented: "
	@rented_cars.each do |car, person|
		puts "The #{car.make} is rented to #{person.name}"
	end
	print_menu(false)
end


print_menu(true)