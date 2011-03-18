require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/aliasing'

module Arel
  module Visitors
    class ToSql
      def visit_Arel_Attributes_Attribute_with_case_insensitive(o)
        Arel::CaseInsensitive.convert_value visit_Arel_Attributes_Attribute_without_case_insensitive(o), :convert_attribute
      end
      alias_method_chain :visit_Arel_Attributes_Attribute, :case_insensitive

      def visit_Arel_Attributes_String_with_case_insensitive(o)
        Arel::CaseInsensitive.convert_value visit_Arel_Attributes_String_without_case_insensitive(o), :convert_attribute
      end
      alias_method_chain :visit_Arel_Attributes_String, :case_insensitive

      def visit_String_with_case_insensitive(o)
        Arel::CaseInsensitive.convert_value visit_String_without_case_insensitive(o), :convert_string
      end
      alias_method_chain :visit_String, :case_insensitive
    end
  end

  class CaseInsensitive
    cattr_accessor :case_insensitive, :convert_attribute, :convert_string

    def self.convert_value(val, method)
      self.case_insensitive ? self.send(method).call(val) : val
    end
  end
end

Arel::CaseInsensitive.case_insensitive = true
Arel::CaseInsensitive.convert_attribute = Proc.new { |val| "UPPER(#{val})" }
Arel::CaseInsensitive.convert_string = Proc.new{ |val| val.upcase }

