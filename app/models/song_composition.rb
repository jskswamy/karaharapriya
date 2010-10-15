class SongComposition < ActiveRecord::Base
  belongs_to :song_type
  belongs_to :song_content_type
  delegate :name, :to => :song_content_type

  validates_presence_of :song_type
  validates_presence_of :song_content_type
  validates_uniqueness_of :song_type_id, :scope => :song_content_type_id
end
