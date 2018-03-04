class Address
  attr_accessor :city, :state, :location

  def initialize(city = nil, state = nil, location = nil)
    @city = city
    @state = state
    @location = Point.new(location[:coordinates][0], location[:coordinates][1]) if location.present?
  end

  def mongoize
    { city: @city, state: @state, loc: @location.mongoize }
  end

  def self.mongoize(object)
    case object
    when nil then
      nil
    when Hash then
      object
    when Address then
      object.mongoize
    end
  end

  def self.demongoize(object)
    case object
    when nil then
      nil
    when Hash then
      Address.new(object[:city], object[:state], object[:loc])
    when Address then
      object
    end
  end

  def self.evolve(object)
    case object
    when nil then
      nil
    when Hash then
      object
    when Address then
      object.mongoize
    end
  end
end