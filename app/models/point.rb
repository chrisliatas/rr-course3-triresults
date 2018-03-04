class Point
  attr_accessor :longitude, :latitude

  def initialize(longitude = nil, latitude = nil)
    @longitude = longitude
    @latitude = latitude
  end

  def mongoize
    { type: 'Point', coordinates: [@longitude, @latitude] }
  end

  def self.mongoize(object)
    case object
    when nil then
      nil
    when Hash then
      object
    when Point then
      object.mongoize
    end
  end

  def self.demongoize(object)
    case object
    when nil then
      nil
    when Hash then
      Point.new(object[:coordinates][0], object[:coordinates][1])
    when Point then
      object
    end
  end

  def self.evolve(object)
    case object
    when nil then
      nil
    when Hash then
      object
    when Point then
      object.mongoize
    end
  end
end