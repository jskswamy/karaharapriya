class SongType < ActiveRecord::Base
  has_many :song_compositions
  validates_uniqueness_of :name
end
