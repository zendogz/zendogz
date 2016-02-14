class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /courses/:id/enrollments
  # GET /courses/:id/enrollments.json
  def index
    @course = Course.find(params[:course_id])
    @enrollments = @course.enrollments
  end

  # GET /courses/:id/enrollments/:id
  # GET /courses/:id/enrollments/:id.json
  def show
  end

  # GET /courses/:id/enrollments/new
  def new
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(
      course: @course,
      status: Code.code_for('enrollment_status', 'pending'),
      enrolled_on: Time.zone.today
    )
    @enrollment.add_student current_user
  end

  # GET /courses/:id/enrollments/:id/edit
  def edit
  end

  # POST /courses/:id/enrollments
  # POST /courses/:id/enrollments.js
  def create
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(enrollment_params[:enrollment])

    authorize @enrollment

    @student = Person.find_by(email: enrollment_params[:person][:email])
    new_student = false
    unless @student
      @student = Person.new(email: enrollment_params[:person][:email])
      new_student = true
    end
    @student.update_attributes(enrollment_params[:person])

    # default password for the new student
    @student.password_confirmation = @student.password = SecureRandom.hex(2)
    @student.roles = ['owner', 'user']
    @enrollment.status = Code.code_for('enrollment_status', 'active')
    @enrollment.person = @student
    @enrollment.enrolled_on = Time.zone.today

    respond_to do |format|
      if @enrollment.save
        # log in the student unless they're already logged in
        @student.login(session) unless current_user

        # email the new student if they were just created
        PersonMailer.new_person_message(@student).deliver_now if new_student

        format.html { redirect_to course_enrollment_path(@course, @enrollment), notice: 'Enrollment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enrollment }
        format.js {
          flash[:notice] = 'Enrollment was successfully created.'
          flash.keep(:notice)
        }
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
