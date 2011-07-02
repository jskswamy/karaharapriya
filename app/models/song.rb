class Song
  include Mongoid::Document
  include Mongoid::Globalize

  field :name, :type => Hash
  field :content, :type => Hash
  referenced_in :song_type
  referenced_in :ragam
  referenced_in :talam
  referenced_in :composer

  validates_presence_of :name, :content, :ragam, :talam, :song_type
  validates_uniqueness_of :name
  translate :name, :content

  def self.find_by_id id
    Song.first(:conditions => {:id => id})
  end

  def to_param
    self.name
  end

end
