class ErrorsService < StandardError
  def initialize(msg)
    super(msg)
  end
end
