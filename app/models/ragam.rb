class Ragam < ActiveRecord::Base
  has_many :song_content_info, :as => :info
  validates_presence_of :name, :arohana, :avarohana
  validates_uniqueness_of :name
  validates_uniqueness_of :arohana, :scope => :avarohana, :message => "and Avarohana already defined for another ragam"
end
