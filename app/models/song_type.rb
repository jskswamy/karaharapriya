class SongType
  include Mongoid::Document
  include Sorter

  field :name
  field :description
  validates_uniqueness_of :name
end
