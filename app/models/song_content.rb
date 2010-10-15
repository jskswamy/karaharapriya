class SongContent < ActiveRecord::Base
  belongs_to :song
  belongs_to :song_content_type
  has_many :song_content_infos

  validates_presence_of :song, :body, :song_content_type
end
