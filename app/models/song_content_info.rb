class SongContentInfo < ActiveRecord::Base
  belongs_to :song_content
  belongs_to :info, :polymorphic => true
end
