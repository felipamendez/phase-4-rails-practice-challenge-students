class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unproccessable_entity
    def index 
        students = Student.all
        render json: students
    end

    def show
         student = Student.find(params[:id])
         render json: student 

    end


    def create
        student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student
    end

    def delete 
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end


    private

    def student_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: {error: "Student not found"}, status: :not_found
    end

    def render_unproccessable_entity(invalid)
        render json: {invalid.record.errors}, status: :render_unproccessable_entity
    end
end
