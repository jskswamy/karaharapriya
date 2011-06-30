class Composer
  include Mongoid::Document
  include Mongoid::Globalize
  include Suggest

  field :name, :type => Hash
  field :century, :type => Hash
  field :info, :type => Hash

  validates_presence_of :name, :info
  validates_uniqueness_of :name
  translate :name, :century, :info

  def to_param
    self.name
  end

end
