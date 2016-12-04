class Guest

  attr_reader :name, :favourite_song
  attr_accessor :cash

  def initialize(name, cash, favourite_song)
    @name = name
    @cash = cash
    @favourite_song = favourite_song
  end

end 