require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/aliasing'

module Arel
  module Visitors
    class ToSql
      [
          ['Arel_Attributes_Attribute', :convert_attribute],
          ['Arel_Attributes_String', :convert_attribute],
          ['String', :convert_string]
      ].each do |type_name, convert_method|
        define_method "visit_#{type_name}_with_case_insensitive" do |o|
          Arel::CaseInsensitive.convert_value send("visit_#{type_name}_without_case_insensitive", o), convert_method
        end
        alias_method_chain "visit_#{type_name}", :case_insensitive
      end
    end
  end

  class CaseInsensitive
    cattr_accessor :case_insensitive, :convert_attribute, :convert_string

    def self.convert_value(val, method)
      self.case_insensitive ? send(method).call(val) : val
    end
  end
end

# Set the default values (for Oracle)
Arel::CaseInsensitive.case_insensitive = true
Arel::CaseInsensitive.convert_attribute = Proc.new { |val| "UPPER(#{val})" }
Arel::CaseInsensitive.convert_string = Proc.new{ |val| val.upcase }

