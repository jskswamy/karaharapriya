class Song < ActiveRecord::Base
  belongs_to :song_type
  validates_uniqueness_of :name, :scope => :song_type_id
end
