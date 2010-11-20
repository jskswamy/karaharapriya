module Suggest
  def self.included(klass)
    klass.class_eval do
      scope :suggest_by_name, lambda { |name = ""| where("name LIKE '%#{name}%'") }
    end
  end
end
