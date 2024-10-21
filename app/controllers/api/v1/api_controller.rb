class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :status_500
  rescue_from ActiveRecord::RecordNotFound, with: :status_404

  def status_404
    render status: 404
  end

  def status_500
    render status: 500
  end
end
