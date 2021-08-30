# frozen_string_literal: true

class Carriage
  include Accessors
  include Validation
  include Manufacturer
  attr_reader :type, :number_carriage, :volume, :occupied_volume

  NUMBER_CARRIAGE_FORMAT = /^[a-z\d]{1}[a-z\d]{1}?$/i.freeze

  validate :number_carriage, :presence
  validate :number_carriage, :format, NUMBER_CARRIAGE_FORMAT
  validate :volume, :presence
  validate :volume, :positive
  validate :volume, :type, Integer

  def initialize(number_carriage, volume)
    @number_carriage = number_carriage
    @volume = volume
    @occupied_volume = 0
    validate!
  end

  def free_volume
    volume - occupied_volume
  end

  protected

  attr_writer :occupied_volume
end
