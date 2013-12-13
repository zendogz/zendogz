require 'spec_helper'

describe 'Courses' do
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
      description = course.description
      get course_path(course)
      response.status.should be(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(description)
    end
  end

  describe 'GET /courses/new' do
    it 'redirects to root while not logged in' do
      get new_course_path
      response.status.should be(302)
      expect(response).to redirect_to(:root)
      follow_redirect!
      expect(response.body).to include('Not authorized')
    end
  end

end
