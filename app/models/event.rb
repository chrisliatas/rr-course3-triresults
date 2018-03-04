class Event
  include Mongoid::Document

  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true, touch: true

  def meters
    case self.u
      when "meters" then
        self.d
      when "kilometers" then
        self.d * 1000
      when "yards" then
        self.d * 0.9144
      when "miles" then
        self.d * 1609.34
    end if self.d
  end

  def miles
    case self.u
      when "meters" then
        self.d * 0.000621371
      when "kilometers" then
        self.d * 0.621371
      when "yards" then
        self.d * 0.000568182
      when "miles" then
        self.d
    end if self.d
  end
end
