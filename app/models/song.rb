class Song < ActiveRecord::Base

  belongs_to :song_type
  belongs_to :composer
  has_many :song_contents

  validates_uniqueness_of :name, :scope => :song_type_id
  validates_presence_of :name

end
