require_relative ('room')
require_relative ('guest')
require_relative ('song')

class Bar

  attr_reader :name
  attr_accessor :rooms, :guests, :total_cash, :capacity, :song_library

  def initialize(name)
    @name = name
    @rooms = []
    @guests = []
    @song_library = []
    @total_cash = 150
    @capacity = 0
  end

  def number_of_rooms()
    @rooms.count()
  end

  def number_of_guests()
    @guests.count()
  end

  def setup_room(room)
    @rooms.push(room)
    @capacity += room.capacity()
  end

  def add_room_interactive()
    if @total_cash < 50
      puts "Adding a new room is an expensive process. It costs 50 $ and your remaining budget is only #{@total_cash}. Therefore you cannot add a new room."
    else
      puts "What is the name of the new room?"
      room_name = gets.chomp
      room_name = room_name.capitalize()
      while @rooms.any? { |i| i.name() == room_name }
        puts "There is already a room callen #{room_name} in your bar, please choose another one."
        room_name = gets.chomp
        room_name = room_name.capitalize()
      end
      puts "What is the capacity of the new room?"
      room_capacity = gets.chomp.to_i
      puts "What is the entry fee for the new room?"
      room_entry_fee = gets.chomp.to_i
      room = Room.new(room_name, room_capacity, room_entry_fee)
      
      @rooms.push(room)
      @capacity += room.capacity()
      @total_cash -= 50
    end
  end

  def build_song_library(room, song)
    room.playlist().push(song.name_and_interpreter())
    @song_library.push(song.name_and_interpreter())
    @song_library.uniq!
    @total_cash -= song.distribution_rights()
  end

  def buy_song_interactive()
    puts "What is the name of the new song?"
    song_name = gets.chomp
    song_name = song_name.capitalize()
    puts "The song distribution rights cost 10$."
    song_price = 10
    song = Song.new(song_name, song_price)

    if @total_cash < song.distribution_rights()
      puts "You cannot purchase the song, cause your remaining budget is lower than the cost of the song."
    else
      puts "Which room do you want the new song to be assigned in?"
      for i in @rooms
        puts i.name()
      end
      room_name = gets.chomp  
      room_name = room_name.capitalize()
      
      while @rooms.none? { |a| a.name() == room_name } 
        puts "The room name does not match, please choose again from our rooms:"
        for b in @rooms
          puts b.name()
        end
        puts "Which room do you want the new song to be assigned in?"
        room_name = gets.chomp
        room_name = room_name.capitalize()
      end

      for c in @rooms
        room = c if c.name() == room_name
      end

      room.playlist().push(song.name_and_interpreter())
      @song_library.push(song.name_and_interpreter())
      @song_library.uniq!
      @total_cash -= song.distribution_rights()
      puts "You have bought a new song called #{song.name_and_interpreter()}, which has been added to the playlist of #{room.name()}."
    end
  end

  def check_song_library()
    @song_library.count()
  end

  def check_in_guest(room, guest)
    if @capacity == 0
      puts "The bar is full, therefore you cannot check in another customer. Tell him to come again later."
    else
      if guest.cash() >= room.entry_fee()
        @guests.push(guest.name())
        room.checked_in_guests().push(guest.name())
        for i in room.playlist()
          puts "The guest says 'Yuhuuuu' out loud, cause he has found #{guest.favourite_song()} on the playlist, and that's his favourite song!" if i == guest.favourite_song()
        end
        @total_cash += room.entry_fee()
        @capacity -= 1
        room.profit += room.entry_fee()
      else
        puts "Sorry, but this guest has not enough money to pay the entry fee. Therefore you cannot let him in."
      end
    end
  end

  def check_in_guest_interactive()
    if @capacity == 0
      puts "The bar is full, therefore you cannot check in another customer. Tell him to come again later."
    else
      puts "What is the name of the new guest?"
      guests_name = gets.chomp
      guests_name = guests_name.capitalize()

      puts "How much money has the guest?"
      guests_cash = gets.chomp.to_i()
      puts "What is the guest's favourite song?"
      guests_favourite_song = gets.chomp
      guest = Guest.new(guests_name, guests_cash, guests_favourite_song)
      puts "Which room do you want the guest to be assigned in?"
      for i in @rooms
        puts i.name() if i.checked_in_guests().count() < i.capacity()
      end
      room_name = gets.chomp  
      room_name = room_name.capitalize()
      while @rooms.none? { |a| a.name() == room_name } 
        puts "The room name does not match, please choose again from our rooms:"
        for b in @rooms
          puts b.name() if b.checked_in_guests().count() < b.capacity()
        end
        puts "Which room do you want the guest to be assigned in?"
        room_name = gets.chomp
        room_name = room_name.capitalize()
      end

      for c in @rooms
        room = c if c.name() == room_name
      end

        if guest.cash() >= room.entry_fee()
          @guests.push(guest.name())
          room.checked_in_guests().push(guest.name())
          for i in room.playlist()
            puts "The guest says 'Yuhuuuu' out loud, cause he has found #{guest.favourite_song()} on the playlist, and that's his favourite song!" if i == guest.favourite_song()
          end
          @total_cash += room.entry_fee()
          @capacity -= 1
          room.profit += room.entry_fee()

        else
          puts "Sorry, but this guest has not enough money to pay the entry fee. Therefore you cannot let him in."
        end
    end
  end

  def check_out_guest(guest)
    if @guests.count() == 0
      puts "There are no guests in the bar to be checked out."
    else
      @guests.delete(guest.name())
      for i in @rooms
        i.checked_in_guests().delete(guest.name())
      end 
      puts "The guest named #{guest.name()} was succesfully checked out."
      @capacity += 1
    end
  end

  def check_out_guest_interactive()
    if @guests.count() > 0
      puts "In your bar are recently following guests:"
      for j in @guests
        puts "#{j}"
      end
      puts "Which one do you want to check out?"
      guest_name = gets.chomp
      guest_name = guest_name.capitalize()

      while @guests.none? { |x| x == guest_name }
        puts "The name does not match, please choose again from guests in bar:"
        for k in @guests
          puts "#{k}"
        end
        puts "Which one do you want to check out?"
        guest_name = gets.chomp
        guest_name = guest_name.capitalize()
      end

      for i in @rooms
        i.checked_in_guests().delete(guest_name)
      end
      @guests.delete(guest_name)
      puts "The guest named #{guest_name} was succesfully checked out."
      @capacity += 1
    else
      puts "There are no guests in the bar to be checked out."
    end
  end

  def see_all_guests()
    for i in @rooms
      puts "Guests in #{i.name()}:"
      i.checked_in_guests().each { |j| puts " #{j} " }
    end
  end

  def see_all_songs()
    for i in @rooms
      puts "Playlist in #{i.name()} contains following songs:"
      i.playlist().each { |j| puts " #{j} "}
    end
  end

  def see_a_room()
    puts "Which room do you want to see in detail?"
    for i in @rooms
      puts i.name()
    end
    room_name = gets.chomp  
    room_name = room_name.capitalize()
    while @rooms.none? { |a| a.name() == room_name } 
      puts "The room name does not match, please choose again from our rooms:"
      for b in @rooms
        puts b.name()
      end
      puts "Which room do you want to see in detail?"
      room_name = gets.chomp
      room_name = room_name.capitalize()
    end
    for c in @rooms
      room = c if c.name() == room_name
    end

    puts "Number of guests in #{room.name()} at the moment is #{room.checked_in_guests.count()}."
    if room.checked_in_guests().count() > 0
      puts "Their names are:"
      room.checked_in_guests().each { |d| puts " #{d} " }
    end
    puts "The #{room.name()}'s playlist contains following songs:"
    room.playlist().each { |e| puts " #{e} " }
    puts "The #{room.name()} has created #{room.profit()}$ profit so far."
  end

end