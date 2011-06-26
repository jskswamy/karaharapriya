class Composer
  include Mongoid::Document
  include Suggest

  field :name, :type => Hash
  field :century
  field :info

  validates_presence_of :name, :info
  validates_uniqueness_of :name

  def to_param
    self.name
  end

end
