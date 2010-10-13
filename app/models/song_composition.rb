class SongComposition < ActiveRecord::Base
  belongs_to :song_type
  belongs_to :song_content_type
  delegate :name, :to => :song_content_type
end
