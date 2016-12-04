class Room

  attr_reader :entry_fee, :capacity, :name
  attr_accessor :playlist, :checked_in_guests, :profit

  def initialize(name, capacity, entry_fee)
    @name = name
    @capacity = capacity
    @entry_fee = entry_fee
    @playlist = []
    @checked_in_guests = []
    @profit = 0
  end
  
end