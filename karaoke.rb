require_relative ('bar')
require_relative ('room')
require_relative ('song')
require_relative ('guest')

puts "Welcome to Karaoke Bar management software. Do you wish to start using it? yes/no"
user_answer = gets.chomp
if user_answer == "yes"
  
########### BAR SETUP ##########################################

  @bar = Bar.new("Karaoke")

  @room1 = Room.new("Room1", 5, 5)
  @room2 = Room.new("Room2", 5, 5)
  @room3 = Room.new("Room3", 5, 5)

  @bar.setup_room(@room1)
  @bar.setup_room(@room2)
  @bar.setup_room(@room3)

  @song1 = Song.new("Loose yourself - Eminem", 10)
  @song2 = Song.new("No woman no cry - Bob Marley", 10)
  @song3 = Song.new("Oops!...I did it again! - Britney Spears", 5)
  @song4 = Song.new("Wonderwall - Oasis", 10)
  @song5 = Song.new("Another brick in the wall - Pink Floyd", 8)
  @song6 = Song.new("Shake it up - Taylor Swift", 10)
  @song7 = Song.new("Next episode - Dr. Dre", 10)
  @song8 = Song.new("Wannabe - Spice Girls", 5)
  @song9 = Song.new("Everybody - Backstreet Boys", 5)
  @song10 = Song.new("Still DRE - Dr. Dre", 10)

  @bar.build_song_library(@room1,@song1)
  @bar.build_song_library(@room1,@song2)
  @bar.build_song_library(@room1,@song3)
  @bar.build_song_library(@room2,@song4)
  @bar.build_song_library(@room2,@song5)
  @bar.build_song_library(@room2,@song6)
  @bar.build_song_library(@room3,@song7)
  @bar.build_song_library(@room3,@song8)
  @bar.build_song_library(@room3,@song9)
  @bar.build_song_library(@room3,@song10)

############## END OF BAR SETUP #################################

  while user_answer == "yes"
    puts ""
    puts "Your bar has recently #{@bar.number_of_rooms()} rooms and the number of guests singing songs at the moment is #{@bar.number_of_guests()}. Your bar offers #{@bar.check_song_library()} songs to choose. Your total cash is #{@bar.total_cash()}$ and remaining capacity of the bar is #{@bar.capacity()}."
    puts "What do you want to do?
          1 - check in new guest
          2 - check out a guest
          3 - buy new song 
          4 - add room 
          5 - see all guests
          6 - see all songs
          7 - see a room
          8 - exit"
    user_action = gets.chomp
    case user_action
    when "1"
      @bar.check_in_guest_interactive()
    when "2"
      @bar.check_out_guest_interactive()
    when "3"
      @bar.buy_song_interactive()
    when "4"
      @bar.add_room_interactive()
    when "5"
      @bar.see_all_guests()
    when "6"
      @bar.see_all_songs()
    when "7"
      @bar.see_a_room()
    when "8"
      user_answer = "no"
      puts "Bye bye!" 
    end   
  end
else
  puts "Bye bye!"
end