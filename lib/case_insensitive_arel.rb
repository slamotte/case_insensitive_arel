require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/aliasing'

module Arel #:nodoc:
  module Visitors #:nodoc: all
    class ToSql
      # List of Arel types that should be converted to make them comparable in a case-insensitive fashion
      %w(Arel_Attributes_Attribute Arel_Attributes_String String).each do |arel_type_name|
        define_method "visit_#{arel_type_name}_with_case_insensitive" do |obj|
          # Get original value
          value = send("visit_#{arel_type_name}_without_case_insensitive", obj)

          # Return either the original case-sensitive value or a converted version
          Arel::CaseInsensitive.leave_case_sensitive?(obj) ? value : Arel::CaseInsensitive.convert_value(value)
        end
        alias_method_chain "visit_#{arel_type_name}", :case_insensitive
      end
    end
  end

  # Controls case-insensitive comparisons. The following attributes can be set to customize behaviour.
  class CaseInsensitive
    # Boolean that determines whether case-insensitive processing is enabled or not. Defaults to:
    #  Arel::CaseInsensitive.case_insensitive = true
    cattr_accessor :case_insensitive

    # Proc that accepts an Arel object and converts it into something that can be compared in a case-insensitive manner. Defaults to:
    #  Arel::CaseInsensitive.conversion_proc = Proc.new { |val| "UPPER(#{val})" }
    cattr_accessor :conversion_proc

    protected

    # Determines whether an object should be converted to case-insensitive form or not
    def self.leave_case_sensitive?(obj)
      if obj.is_a?(Arel::Attributes::Attribute) and obj.relation.is_a?(Arel::Table)
        # Determine the attribute's type
        cn = obj.relation.engine.connection_pool.connection
        column = if cn.is_a?(Hash)
          # This works for FakeRecord
          cn.columns[obj.relation.name][obj.name.to_s]
        else
          # This works for Oracle Enhanced
          cn.columns(obj.relation.name).find{|col|col.name.eql?(obj.name.to_s)}
        end
        column_type = column ? column.type : nil
        return true unless column_type == :string
      end

      # Last checks
      obj.respond_to?(:do_not_make_case_insensitive?) or
      (obj.respond_to?(:name) && obj.name.eql?('*'))
    end

    private

    # Return the converted value or the value itself depending on the current state of +case_insensitive+
    def self.convert_value(val)
      case_insensitive ? conversion_proc.call(val) : val
    end
  end

  class Table # :nodoc:
    # We don't want an attribute in the SELECT to be processed by the conversion proc. As such, tag +project+'s' parameters with a special
    # singleton method to prevent them from being converted.
    def project_with_case_insensitive(*things)
      # If a +thing+ is used elsewhere (e.g. in the WHERE clause), tagging it will cause the WHERE clause to be affected as well. So create a new
      # list of things and tag them instead.
      new_things = things.map do |thing|
        new_thing = thing.clone
        def new_thing.do_not_make_case_insensitive?; end
        new_thing
      end
      project_without_case_insensitive *new_things
    end
    alias_method_chain :project, :case_insensitive
  end
end

# Set the default values (these work for Oracle)
Arel::CaseInsensitive.case_insensitive = true
Arel::CaseInsensitive.conversion_proc = Proc.new { |val| "UPPER(#{val})" }
