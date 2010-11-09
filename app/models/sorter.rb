module Sorter
  def self.included(klass)
    klass.class_eval do
      scope :ascending, :order => "name asc"
    end
  end
end
