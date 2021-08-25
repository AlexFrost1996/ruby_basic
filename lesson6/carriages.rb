# frozen_string_literal: true

class Carriages
  include Validate
  include Manufacturer
  attr_reader :type

  TYPE = %i[passenger cargo].freeze

  def initialize(type)
    @type = type
    validate!
  end

  private

  def validate!
    raise "Invalid type of carriage!" unless TYPE.include?(type)
  end
end
