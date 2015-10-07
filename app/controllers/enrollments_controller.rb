class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @course = Course.find(params[:course_id])
    @enrollments = @course.enrollments
    logger.info('enrollments')
    logger.info(@enrollments)
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(
      course: @course,
      status: Code.code_for('enrollment_status', 'pending'),
      enrolled_on: Time.zone.today
    )
    @enrollment.add_student current_user
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.js
  def create
    # @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(enrollment_params[:enrollment])

    authorize @enrollment

    @student = Person.new(enrollment_params[:person])
    # # default password for the new student
    @student.password = 'pass'
    @student.password_confirmation = 'pass'
    @student.roles = ['user']
    @enrollment.status = Code.code_for('enrollment_status', 'active')
    @enrollment.person = @student
    @enrollment.enrolled_on = Time.zone.today
    # @enrollment.save
    # respond_to :html, :js
byebug
    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to course_enrollment_path(@course, @enrollment), notice: 'Enrollment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enrollment }
        format.js {}
      else
        format.html { render action: 'new' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
        format.js {
          logger.info(@enrollment.errors)
          render action: 'error' }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html do
          redirect_to course_enrollment_path(@course, @enrollment), notice: 'Enrollment was successfully updated.'
        end
        format.json { render action: 'show', status: :ok, location: @enrollment }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to course_enrollments_url(@course) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enrollment
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def enrollment_params
    params.permit(
      { enrollment: [:course_id] }, :person_id, :course_id, :status_id, :utf8, :commit,
      person: [:name, :email, :address, :city, :postal, :phone_home, :phone_cell, :phone_work, :born_on]
    )
  end
end
