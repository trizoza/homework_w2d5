class Song
  
  attr_reader :name_and_interpreter, :distribution_rights

  def initialize(name_and_interpreter, distribution_rights)
    @name_and_interpreter = name_and_interpreter
    @distribution_rights = distribution_rights
  end

end