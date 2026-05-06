class Api::V1::ResultsController < ApplicationController

    def create
        result = Result.new(result_params)

        if result.save
            render json: {message: "Successfully Saved!!"}, status: :created
        else
            render json: {errors: result.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def result_params
        params.permit(:student_name, :subject, :marks, :taken_at)
    end
end
