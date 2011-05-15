class Composer
  include Mongoid::Document
  include Suggest

  field :name
  field :century
  field :info

  validates_presence_of :name

end
