class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unproccessable_entity
    def index 
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
         instructor = Instructor.find(params[:id])
         render json: instructor, status: :ok

    end


    def create
        instructor.create!(instructor_params)
        render json: instructor, status: :created
        
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, 
    end

    def delete 
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end


    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def render_unproccessable_entity(invalid)
        render json: {invalid.record.errors}, status: :render_unproccessable_entity
    end
end
