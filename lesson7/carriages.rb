class Carriages
  include Manufacturer, Validate
  attr_reader :type, :number_carriages, :volume, :occupied_volume

  def initialize(number_carriages, volume)
    @number_carriages = number_carriages
    @volume = volume
    @occupied_volume = 0
  end

  def free_volume
    volume - occupied_volume
  end

  protected

  attr_writer :occupied_volume
  
  def validate!
    errors = []
    errors << "Volume can't be nil" if volume.nil?
    errors << "Volume can't be zero" if volume.zero?
    errors << "Volume must be positive" if volume.to_f.negative?
    raise errors.join(". ") unless errors.empty?
  end
end