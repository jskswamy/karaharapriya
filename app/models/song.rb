class Song < ActiveRecord::Base
  belongs_to :song_type
  belongs_to :composer
  validates_uniqueness_of :name, :scope => :song_type_id
end
