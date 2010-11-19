class Composer < ActiveRecord::Base
  include Sorter, Suggest

  validates_presence_of :name
  has_many :songs


end
