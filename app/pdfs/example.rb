class Example
  include Prawn::View

  def initialize(data, message)
    content
    message = @message
  end

  def content
    text @message
  end
end