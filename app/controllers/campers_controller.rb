class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :camper_valition_failed

    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    def show
        camper = find_camper
        render json: camper, status: :ok, serializer: CamperActivitySerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end


    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def camper_not_found
        render json: {"error": "Camper not found"}, status: :not_found
    end

    def camper_valition_failed
        render json: {"errors": ["validation errors"]}, status: 422
    end

end
