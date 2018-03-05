class RacerInfo
  include Mongoid::Document

  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address
  field :racer_id, as: :_id
  field :_id, default: -> { racer_id }

  embedded_in :parent, polymorphic: true

  validates_presence_of :first_name, :last_name, :gender, :birth_year
  validates :gender, inclusion: { in: %w[M F] }
  validates :birth_year, numericality: { less_than: Date.current.year }

  ["city", "state"].each do |action|
    define_method("#{action}") do
      self.residence ? self.residence.send("#{action}") : nil
    end
    define_method("#{action}=") do |name|
      object=self.residence ||= Address.new
      object.send("#{action}=", name)
      self.residence=object
    end
  end

  DEFAULT_EVENTS = { "swim" => { :order=>0, :name=>"swim", :distance=>1.0, :units=>"miles" },
                     "t1" =>   { :order=>1, :name=>"t1" },
                     "bike" => { :order=>2, :name=>"bike", :distance=>25.0, :units=>"miles" },
                     "t2" =>   { :order=>3, :name=>"t2" },
                     "run" =>  { :order=>4, :name=>"run", :distance=>10.0, :units=>"kilometers" } }

  DEFAULT_EVENTS.keys.each do |name|
    define_method("#{name}") do
      event=events.select {|event| name==event.name}.first
      event||=events.build(DEFAULT_EVENTS["#{name}"])
    end
    ["order","distance","units"].each do |prop|
      if DEFAULT_EVENTS["#{name}"][prop.to_sym]
        define_method("#{name}_#{prop}") do
          event=self.send("#{name}").send("#{prop}")
        end
        define_method("#{name}_#{prop}=") do |value|
          event=self.send("#{name}").send("#{prop}=", value)
        end
      end
    end
  end

  def self.default
    Race.new do |race|
      DEFAULT_EVENTS.keys.each {|leg|race.send("#{leg}")}
    end
  end
end
