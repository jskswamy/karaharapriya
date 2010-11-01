class SongType < ActiveRecord::Base
  include Sorter
  has_many :song_compositions
  validates_uniqueness_of :name
end
