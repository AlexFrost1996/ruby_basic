class CargoCarriages < Carriages
  def initialize(number_carriages, volume)
    super
    @type = :cargo
    validate!
  end

  def occupy_volume!(volume)
    errors_volume = []
    errors_volume << "Can't take more than the allowed volume" if volume > free_volume
    errors_volume << "Volume can't be zero" if volume.zero?
    errors_volume << "Volume can't be negative" if volume.negative?
    errors_volume << "Volume can't be nil" if volume.to_f.nil?
    raise errors_volume.join(". ") unless errors_volume.empty? 
    self.occupied_volume += volume if free_volume > volume
  end

  private

  attr_writer :occupied_volume

  def validate!
    super
    errors << "Volume must be a number" unless (volume.class == Float || volume.class == Integer)
  end
end