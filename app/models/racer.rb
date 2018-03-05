class Racer
  include Mongoid::Document

  embeds_one :info, class_name: 'RacerInfo', autobuild: true, as: :parent

  has_many :races, class_name: 'Entrant', dependent: :nullify, foreign_key: 'racer.racer_id', order: :"race.date".desc

  before_create do |racer|
    racer.info.id = racer.id
  end
end
