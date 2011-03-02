module Suggest
  def self.included(klass)
    klass.class_eval do
      scope :suggest_by_name, lambda { |name| where(:name => /#{name}/i) }
    end
  end
end
