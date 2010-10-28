class SongType < ActiveRecord::Base
  include Sorter
  scope :ascending, :order => "name asc"
  has_many :song_compositions
  validates_uniqueness_of :name
end
