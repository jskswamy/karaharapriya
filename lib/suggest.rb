module Suggest
  def self.included(klass)
    klass.class_eval do
      scope :suggest_by_name, lambda {|name|
        is_translated = klass.respond_to?(:translated_field) ? klass.translated_field("name").present? : false
        parameter_name = is_translated ? "name.en" : "name"
        where(parameter_name => /#{name}/i)
      }
    end
  end
end
