class Ragam < ActiveRecord::Base
  has_many :songs
  include Sorter
  validates_presence_of :name, :arohana, :avarohana
  validates_uniqueness_of :name
  validates_uniqueness_of :arohana, :scope => :avarohana, :message => "and Avarohana already defined for another ragam"
  validate :minimum_length

  def minimum_length
    errors.add(:base, "Arohana should have atleast 5 swaras") if !self.arohana.blank? && self.arohana.split(" ").count < 5
    errors.add(:base, "Avarohana should have atleast 5 swaras") if !self.avarohana.blank? && self.avarohana.split(" ").count < 5
  end

end
