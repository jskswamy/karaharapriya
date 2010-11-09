class Composer < ActiveRecord::Base
  include Sorter

  validates_presence_of :name
  has_many :songs

end
