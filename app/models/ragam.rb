class Ragam < ActiveRecord::Base
  has_many :song_content_info, :as => :info
  validates_presence_of :name, :arohana, :avarohana
  validates_uniqueness_of :name
  validates_uniqueness_of :arohana, :scope => :avarohana, :message => "and Avarohana already defined for another ragam"
  validate :minimum_length

  #TODO: refactor this in ruby style
  def minimum_length
    unless self.arohana.blank?
      errors.add(:base, "Arohana should have atleast 5 swaras") unless self.arohana.split(" ").count >= 5
    end
    unless self.avarohana.blank?
      errors.add(:base, "Avarohana should have atleast 5 swaras") unless self.avarohana.split(" ").count >= 5
    end
  end

end
