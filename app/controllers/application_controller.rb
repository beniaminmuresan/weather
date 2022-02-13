# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_with_reason

  private

    def not_found_with_reason(error)
      render json: { error_message: error.message }, status: :not_found
    end
end
