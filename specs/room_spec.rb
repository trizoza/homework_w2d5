require ('minitest/autorun')
require ('minitest/rg')
require_relative ('../room')
require_relative ('../song')

class BarSpec < MiniTest::Test

  def setup
    @room_1 = Room.new("Room1", 5, 5)
    @room_2 = Room.new("Room2", 5, 5)
    @room_3 = Room.new("Room3", 5, 5)
  end

  def test_room_name
    assert_equal("Room1", @room_1.name())
  end

  def test_room_capacity
    assert_equal(5, @room_1.capacity())
  end

  def test_room_entry_fee
    assert_equal(5, @room_2.entry_fee())
  end

  def test_room_profit
    assert_equal(0, @room_1.profit())
  end

end