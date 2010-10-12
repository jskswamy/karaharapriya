class SongContent < ActiveRecord::Base
  belongs_to :song_content_type
  validates_uniqueness_of :name
end
