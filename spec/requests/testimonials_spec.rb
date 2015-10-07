require 'spec_helper'

describe 'Testimonial requests' do
  describe 'GET /testimonials' do
    it 'lists testimonials' do
      get testimonials_path
      response.status.should be(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /testimonials/1' do
    let(:testimonial) { create(:testimonial) }
    it 'shows the specified testimonial' do
      get testimonial_path(testimonial)
      response.status.should be(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(testimonial.body)
    end
  end

  context 'not logged in as admin' do
    describe 'GET /testimonials/new' do
      it 'prevents creating a testimonial' do
        get new_testimonial_path
        response.status.should be(302)
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Not authorized')
      end
    end

    describe 'GET /testimonials/1/edit' do
      let(:testimonial) { create(:testimonial) }
      it 'prevents editing a testimonial' do
        get edit_testimonial_path(testimonial)
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

    describe 'GET /testimonials/new' do
      it 'shows create form' do
        get new_testimonial_path
        response.status.should be(200)
        # expect(response.body).to include('New testimonial')
      end
    end

    describe 'GET /testimonials/1/edit' do
      let(:testimonial) { create(:testimonial) }
      it 'shows the form to edit a testimonial' do
        get edit_testimonial_path(testimonial)
        response.status.should be(200)
        expect(response).to render_template(:edit)
        expect(response.body).to include('Editing testimonial')
      end
    end

    describe 'POST /testimonials' do
      it 'creates a testimonial' do
        count = Testimonial.count
        post testimonials_path, testimonial: { from: 'somebody', body: 'new testimonial body' }
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(Testimonial.count).to eq(count + 1)
        expect(response.body).to include('Testimonial was successfully created.')
      end
    end

    describe 'PUT /testimonial/1' do
      let(:testimonial) { create(:testimonial) }
      it 'updates a testimonial' do
        testimonial.save
        count = Testimonial.count
        put testimonial_path(testimonial), testimonial: { from: 'updated name', body: 'updated body' }
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(Testimonial.count).to eq(count)
        expect(response.body).to include('Testimonial was successfully updated.')
      end
    end

    describe 'DELETE /testimonial/1' do
      let(:testimonial) { create(:testimonial) }
      it 'destroys a testimonial' do
        testimonial.save
        count = Testimonial.count
        delete testimonial_path(testimonial)
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(Testimonial.count).to eq(count - 1)
      end
    end
  end
end
