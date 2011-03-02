class Song
  include Mongoid::Document

  field :name
  field :content
  field :description
  referenced_in :song_type
  referenced_in :ragam
  referenced_in :talam
  referenced_in :composer

  validates_presence_of :name, :ragam, :talam, :song_type
  validates_uniqueness_of :name

end
