class Composer
  include Mongoid::Document
  include Mongoid::Globalize
  include Suggest

  field :name, :type => Hash
  field :century, :type => Hash

  validates_presence_of :name
  validates_uniqueness_of :name
  translate :name, :century

  def to_param
    self.name
  end

end
