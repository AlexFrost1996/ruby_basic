# frozen_string_literal: true

class Carriages
  include Manufacturer
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
