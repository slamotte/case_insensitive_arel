require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/aliasing'

module Arel
  module Visitors
    class ToSql
      # List of Arel types that should be converted to upper or lower case
      %w(Arel_Attributes_Attribute Arel_Attributes_String String).each do |arel_type_name|
        convert_method = case arel_type_name
                           when /^Arel_Attributes_.+/
                             :convert_attribute
                           when 'String'
                             :convert_string
                           else
                             raise "Unexpected Arel type name: #{arel_type_name}"
                         end
        define_method "visit_#{arel_type_name}_with_case_insensitive" do |o|
          value = send("visit_#{arel_type_name}_without_case_insensitive", o)
          o.respond_to?(:do_not_make_case_insensitive?) ? value : Arel::CaseInsensitive.convert_value(value, convert_method)
        end
        alias_method_chain "visit_#{arel_type_name}", :case_insensitive
      end
    end
  end

  class CaseInsensitive
    cattr_accessor :case_insensitive, :convert_attribute, :convert_string

    def self.convert_value(val, method)
      case_insensitive ? send(method).call(val) : val
    end
  end

  class Table
    def project_with_case_insensitive(*things)
      things = things.map do |thing|
        new_thing = thing.clone # Need to clone these because we might want to use an attribute in the SELECT and WHERE clauses, but the former shouldn't be altered
        def new_thing.do_not_make_case_insensitive?; true; end
        new_thing
      end
      project_without_case_insensitive *things
    end
    alias_method_chain :project, :case_insensitive
  end
end

# Set the default values (for Oracle)
Arel::CaseInsensitive.case_insensitive = true
Arel::CaseInsensitive.convert_attribute = Proc.new { |val| "UPPER(#{val})" }
Arel::CaseInsensitive.convert_string = Proc.new{ |val| val.upcase }

