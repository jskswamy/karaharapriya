class RemoteResponse

  attr_reader :errors, :redirect_url, :model_name

  def initialize model, url
    @model_name = model.class.name.downcase
    @errors = model.errors.map { |field| {:field => field, :errors => model.errors[field]} }
    @redirect_url = url
  end

end
