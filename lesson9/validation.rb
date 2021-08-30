module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *param)
      @validate ||= []
      @validate << {name: name, type: type, param: param}
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def validate!
      self.class.instance_variable_get("@validate").each do |hash|
        name = hash[:name]
        value = instance_variable_get("@#{name}")
        type = hash[:type]
        param = hash[:param][0]
        send("validate_#{type}", name, value, param)
      end
    end
    
    def validate_presence(name, value, _)
      raise "#{name} should be present!" if value.nil? || value.to_s.empty?
    end

    def validate_format(name, value, regexp)
      raise "Format #{name} should be #{regexp}!" if value !~ regexp
    end

    def validate_type(name, value, type)
      raise "Type #{name} should be #{type}" unless value.is_a?(type)
    end

    def validate_positive(name, value, _)
      raise "#{name} should be positive" unless value.positive?
    end

    def validate_length(name, value, param)
      raise "Length of #{name} should be at least #{param}" if value.length < param
    end
  end
end