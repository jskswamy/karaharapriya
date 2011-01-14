class Song < ActiveRecord::Base

  belongs_to :song_type
  belongs_to :composer
  belongs_to :ragam
  belongs_to :talam
  has_many :song_contents, :dependent => :destroy

  validates_uniqueness_of :name, :scope => :song_type_id
  validates_presence_of :name

  def save_with_contents song_contents
    self.song_contents << song_contents.collect { |song_content| SongContent.new(song_content.merge(:song => self)) } and return true if self.save
    false
  end

end
