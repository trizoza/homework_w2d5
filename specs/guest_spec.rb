require ('minitest/autorun')
require ('minitest/rg')
require_relative ('../guest')

class GuestSpec < MiniTest::Test

  def setup
    @guest1 = Guest.new("Peter", 5, "Loose yourself - Eminem")
    @guest2 = Guest.new("Blaise", 8, "Oops!...I did it again! - Britney Spears")
    @guest3 = Guest.new("Kamila", 6, "Wonderwall - Oasis")
    @guest4 = Guest.new("John", 10, "No woman no cry - Oasis")
    @guest5 = Guest.new("Jack", 4, "Another brick in the wall - Pink Floyd")
  end

  def test_guest_name
    assert_equal("Peter", @guest1.name())
  end

  def test_guest_cash
    assert_equal(8, @guest2.cash())
  end

  def test_guest_favourite_song
    assert_equal("Wonderwall - Oasis", @guest3.favourite_song())  
  end

end