class Ragam
  include Mongoid::Document
  include Suggest

  field :name
  field :arohana
  field :avarohana
  field :description
  referenced_in :parent, :class_name => "Ragam"
  attr_protected :_id

  validates_presence_of :name, :arohana, :avarohana, :description
  validates_uniqueness_of :name
  validates_uniqueness_of :arohana, :scope => :avarohana
  validate :minimum_length

  scope :find_by_name, lambda { |name| where(:name => name) }

  def minimum_length
    errors.add(:base, "Arohana should have atleast 5 swaras") if !self.arohana.blank? && self.arohana.split(" ").count < 5
    errors.add(:base, "Avarohana should have atleast 5 swaras") if !self.avarohana.blank? && self.avarohana.split(" ").count < 5
  end

  def to_param
    self.name
  end

end
