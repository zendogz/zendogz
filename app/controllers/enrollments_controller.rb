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
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(course: @course)

    if admin?
      # logged in as admin
      logger.info('logged in as admin')
      if enrollment_params[:person]
        # have a person
        logger.info('have a person')
        @student = Person.create(enrollment_params[:person])
        @enrollment.person = @student
      else
        # need to build a person
        logger.info('need to build a person: ')
        @person = @enrollment.build_person
        logger.info(@person.inspect)
        render 'new'
        return
      end
    else
      logger.info('NOT logged in as admin')
      if @current_user
        # logged in as non-admin
        logger.info('logged in as non-admin')
        @enrollment.person = @current_user
      elsif params[:enrollment]
        # buil person from params
        logger.info('not logged in, build student from params')
        @student = Person.create(enrollment_params[:person])
        @enrollment.person = @student
      else
        # need to build a person
        logger.info('not logged in, need to build a student: ')
        @person = @enrollment.build_person
        logger.info(@person.inspect)
        render 'new'
        return
      end
    end
    logger.info(@enrollment.inspect)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to course_enrollment_path(@course, @enrollment), notice: 'Enrollment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enrollment }
        format.js {}
      else
        format.html { render action: 'new' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to course_enrollment_path(@course, @enrollment), notice: 'Enrollment was successfully updated.' }
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
      params.require(:enrollment).permit(:person_id, :course_id, :status_id, person_attributes: [:name, :email, :password, :password_confirmation, :address, :city, :postal, :phone_home, :phone_cell, :phone_work, :born_on])
    end
end
