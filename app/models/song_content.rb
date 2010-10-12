class SongContent < ActiveRecord::Base
  belongs_to :song
  belongs_to :song_content_type
  has_many :song_content_infos
end
