module Mongoid
  module Globalize

    DEFAULT_LANGUAGE = :en

    def self.included(base)
      base.before_validation :validate_translated_field_uniqueness

      class << base

        def translated_fields
          @translated_fields ||= []
        end

        def translated_field field_name
          self.translated_fields.find{|translated_field| translated_field[:name] == field_name}
        end

        def find_by_translated_field field_name, value, language = DEFAULT_LANGUAGE
          return if self.translated_field(field_name).nil?
          self.first(:conditions => conditions = {"#{field_name}.#{DEFAULT_LANGUAGE}" => value})
        end

        private

        def translate *fields
          @translated_fields ||= []
          uniqueness_validators = self.validators.select {|validator| validator.kind_of?(Mongoid::Validations::UniquenessValidator)}
          fields.each do |field|
            field_name = field.to_s
            is_unique = uniqueness_validators.find{|unique_validtor| unique_validtor.attributes.include?(field)}.present?
            next unless self.fields.keys.include?(field_name)
            self.send(:add_translation_helper, field_name)
            self.send(:remove_uniqueness_validator, field_name)
            translated_field = {:name => field_name, :unique => is_unique}
            @translated_fields << translated_field unless @translated_fields.include?(translated_field)
          end
        end

        def add_translation_helper field_name
          class_eval do
            define_method "#{field_name}" do |language = "#{DEFAULT_LANGUAGE}"|
              self.send(:get_translation, field_name, language)
            end
            define_method "#{field_name}=" do |value|
              self.send(:add_translation, field_name, value)
            end
          end
        end

        def remove_uniqueness_validator field_name
          field_name = field_name.to_sym
          uniqueness_validators = self.validators.select {|validator| validator.kind_of?(Mongoid::Validations::UniquenessValidator) ? validator.attributes.include?(field_name):false}
          uniqueness_validators.each {|validator| validator.attributes.delete(field_name)}
        end

      end
    end

    def get_translation field, language = DEFAULT_LANGUAGE
      return if self.class.translated_field(field).nil?
      attribute = self.attributes[field]
      language_specific_value = attribute.nil? ? nil : attribute[language.to_s]
      language_specific_value
    end

    def add_translation field, value, language = DEFAULT_LANGUAGE
      return if self.class.translated_field(field).nil?
      old_value = self.send("#{field}_was")
      attribute = self.attributes[field] || {}
      attribute.merge!({language.to_s => value})
      self.changes.merge!({field.to_s => [old_value.nil? ? nil : old_value.clone, attribute]})
      self.attributes[field] = attribute
    end

    private

    def validate_translated_field_uniqueness
      self.class.translated_fields.each do |translated_field|
        field_name = translated_field[:name]
        next unless self.errors[field_name.to_sym].blank?
        conditions = {"#{field_name}.#{DEFAULT_LANGUAGE}" => self.send(field_name), "_id.ne" => self.new? ? nil : self.id}
        exists = self.class.exists?(:conditions => conditions)
        self.errors.add(field_name, "is already taken") if translated_field[:unique] && exists
      end
    end

  end
end
