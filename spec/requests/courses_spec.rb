require 'spec_helper'

describe 'Course requests' do
  describe 'GET /courses' do
    it 'lists courses' do
      get courses_path
      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /courses/1' do
    let(:course) { create(:course) }
    it 'shows the specified course' do
      get course_path(course)
      response.status.should be(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(course.description)
    end
  end

  context 'not logged in as admin' do
    describe 'GET /courses/new' do
      it 'prevents creating a course' do
        get new_course_path
        response.status.should be(302)
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Not authorized')
      end
    end

    describe 'GET /courses/1/edit' do
      let(:course) { create(:course) }
      it 'prevents editing a course' do
        get edit_course_path(course)
        response.status.should be(302)
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Not authorized')
      end
    end
  end

  context 'logged in as admin' do
    let(:admin) { create(:person, roles: ['admin']) }
    before(:each) do
      post sessions_path, email: admin.email, password: admin.password
    end

    describe 'GET /courses/new' do
      it 'shows create form' do
        get new_course_path
        response.status.should be(200)
        # expect(response.body).to include('New Course')
      end
    end

    describe 'GET /courses/1/edit' do
      let(:course) { create(:course) }
      it 'shows the form to edit a course' do
        get edit_course_path(course)
        response.status.should be(200)
        expect(response).to render_template(:edit)
        expect(response.body).to include('Editing course')
      end
    end

    describe 'POST /courses' do
      it 'creates a course' do
        count = Course.count
        post courses_path, course: { name: 'new course', description: 'new course description' }
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(Course.count).to eq(count + 1)
        expect(response.body).to include('Course was successfully created.')
      end
    end

    describe 'PUT /course/1' do
      let(:course) { create(:course) }
      it 'updates a course' do
        course.save
        count = Course.count
        put course_path(course), course: { name: 'updated name', description: 'updated description' }
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(Course.count).to eq(count)
        expect(response.body).to include('Course was successfully updated.')
      end
    end

    describe 'DELETE /course/1' do
      let(:course) { create(:course) }
      it 'destroys a course' do
        course.save
        count = Course.count
        delete course_path(course)
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(Course.count).to eq(count - 1)
      end
    end
  end
end
