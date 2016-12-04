require ('minitest/autorun')
require ('minitest/rg')
require_relative ('../bar')
require_relative ('../room')
require_relative ('../guest')
require_relative ('../song')

class BarSpec < MiniTest::Test

  def setup
    @bar = Bar.new("Karaoke")

    @room1 = Room.new("Room1", 5, 5)
    @room2 = Room.new("Room2", 5, 5)
    @room3 = Room.new("Room3", 5, 5)

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

    @guest1 = Guest.new("Peter", 5, "Loose yourself - Eminem")
    @guest2 = Guest.new("Blaise", 8, "Oops!...I did it again! - Britney Spears")
    @guest3 = Guest.new("Kamila", 6, "Wonderwall - Oasis")
    @guest4 = Guest.new("Harrison", 7, "No woman no cry - Fugees")
    @guest5 = Guest.new("Rory", 4, "Wannabe - Spice girls")
    @guest6 = Guest.new("Nina", 8, "99 Lufballons - Nina")
    @guest7 = Guest.new("Dave", 9, "Another brick in the wall - Pink floyd")
  end

  def test_bar_name()
    assert_equal("Karaoke", @bar.name())
  end

  def test_bar_rooms()
    @bar.setup_room(@room1)
    @bar.setup_room(@room2)
    @bar.setup_room(@room3)
    assert_equal(3, @bar.number_of_rooms())
    assert_equal(15, @bar.capacity())
  end

  def test_build_song_library()
    @bar.setup_room(@room1)
    @bar.build_song_library(@room1,@song1)
    assert_equal("Loose yourself - Eminem", @room1.playlist()[0])
    assert_equal(140, @bar.total_cash())
  end

  def test_check_in_guest_without_favourite_song()
    @bar.setup_room(@room1)
    @bar.setup_room(@room2)
    @bar.setup_room(@room3)

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

    @bar.check_in_guest(@room1, @guest6)

    assert_equal(72, @bar.total_cash())
    assert_equal("Nina", @room1.checked_in_guests.first())
    assert_equal("Nina", @bar.guests().first())
    assert_equal(1, @bar.number_of_guests())
    assert_equal(1, @room1.checked_in_guests().count())
  end

  def test_check_in_guest_with_favourite_song()
    @bar.setup_room(@room1)
    @bar.setup_room(@room2)
    @bar.setup_room(@room3)

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

    @bar.check_in_guest(@room1, @guest1)

    assert_equal(72, @bar.total_cash())
    assert_equal("Peter", @room1.checked_in_guests.first())
    assert_equal("Peter", @bar.guests().first())
    assert_equal(1, @bar.number_of_guests())
    assert_equal(1, @room1.checked_in_guests().count())
  end

  def test_check_in_guest_without_cash()
    @bar.setup_room(@room1)
    @bar.setup_room(@room2)
    @bar.setup_room(@room3)

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

    @bar.check_in_guest(@room1, @guest5)

    assert_equal(67, @bar.total_cash())
    assert_equal(nil, @room1.checked_in_guests.first())
    assert_equal(nil, @bar.guests().first())
    assert_equal(0, @bar.number_of_guests())
    assert_equal(0, @room1.checked_in_guests().count())
  end

  def test_check_in_more_guests()
    @bar.setup_room(@room1)
    @bar.setup_room(@room2)
    @bar.setup_room(@room3)

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

    @bar.check_in_guest(@room2, @guest1)
    @bar.check_in_guest(@room2, @guest2)
    @bar.check_in_guest(@room1, @guest3)

    assert_equal(82, @bar.total_cash())
    assert_equal(["Peter", "Blaise"] , @room2.checked_in_guests())
    assert_equal(["Kamila"] , @room1.checked_in_guests())
    assert_equal(["Peter", "Blaise", "Kamila"], @bar.guests())
    assert_equal(3, @bar.number_of_guests())
    assert_equal(2, @room2.checked_in_guests().count())
    assert_equal(1, @room1.checked_in_guests().count())
  end

  def test_check_out_guest()
    @bar.setup_room(@room1)
    @bar.setup_room(@room2)
    @bar.setup_room(@room3)

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

    @bar.check_in_guest(@room2, @guest1)
    @bar.check_in_guest(@room2, @guest2)
    @bar.check_in_guest(@room1, @guest3)

    @bar.check_out_guest(@guest2)

    assert_equal(82, @bar.total_cash())
    assert_equal(["Peter"] , @room2.checked_in_guests())
    assert_equal(["Kamila"] , @room1.checked_in_guests())
    assert_equal(["Peter", "Kamila"], @bar.guests())
    assert_equal(2, @bar.number_of_guests())
    assert_equal(1, @room2.checked_in_guests().count())
    assert_equal(1, @room1.checked_in_guests().count())
  end

end