class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :signup_valition_failed

    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def signup_valition_failed
        render json: {"errors": ["validation errors"]}, status: 422
    end

end
