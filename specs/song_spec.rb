require ('minitest/autorun')
require ('minitest/rg')
require_relative ('../song')

class SongSpec < MiniTest::Test

  def setup
    @song1 = Song.new("Loose yourself - Eminem", 10)
    @song2 = Song.new("No woman no cry - Bob Marley", 10)
    @song3 = Song.new("Oops!...I did it again! - Britney Spears", 5)
    @song4 = Song.new("Wonderwall - Oasis", 10)
  end

  def test_name_of_song
    assert_equal("Loose yourself - Eminem", @song1.name_and_interpreter())
  end

  def test_price_of_song
    assert_equal(5, @song3.distribution_rights())
  end

end