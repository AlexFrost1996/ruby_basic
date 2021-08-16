class Carriages
  include Manufacturer, Validate
  attr_reader :type
  TYPE = [:passenger, :cargo]

  def initialize(type)
    @type = type
    validate!
  end

  private

  def validate!
    raise "Invalid type of carriage!" unless TYPE.include?(self.type)
  end
end