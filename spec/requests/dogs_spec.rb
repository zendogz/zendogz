require 'spec_helper'

describe 'Dog requests' do
  context 'not logged in as admin or owner' do
    describe 'GET /dogs' do
      it 'lists dogs' do
        get dogs_path
        response.status.should be(302)
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Not authorized')
      end
    end

    describe 'GET /dogs/1' do
      let(:dog) { create(:dog) }
      it 'shows the specified dog' do
        get dog_path(dog)
        response.status.should be(302)
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Not authorized')
      end
    end

    describe 'GET /dogs/new' do
      it 'prevents creating a dog' do
        get new_dog_path
        response.status.should be(302)
        expect(response).to redirect_to(:root)
        follow_redirect!
        expect(response.body).to include('Not authorized')
      end
    end

    describe 'GET /dogs/1/edit' do
      let(:dog) { create(:dog) }
      it 'prevents editing a dog' do
        get edit_dog_path(dog)
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

    describe 'GET /dogs/new' do
      it 'shows create form' do
        get new_dog_path
        response.status.should be(200)
        # expect(response.body).to include('New dog')
      end
    end

    describe 'GET /dogs/1/edit' do
      let(:dog) { create(:dog) }
      it 'shows the form to edit a dog' do
        get edit_dog_path(dog)
        response.status.should be(200)
        expect(response).to render_template(:edit)
        expect(response.body).to include('Editing dog')
      end
    end

    describe 'POST /dogs' do
      it 'creates a dog' do
        count = Dog.count
        post dogs_path, dog: { name: 'new dog', colour: 'speckled' }
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(Dog.count).to eq(count + 1)
        expect(response.body).to include('Dog was successfully created.')
      end
    end

    describe 'PUT /dog/1' do
      let(:dog) { create(:dog) }
      it 'updates a dog' do
        dog.save
        count = Dog.count
        put dog_path(dog), dog: { name: 'updated name', description: 'updated description' }
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:show)
        expect(Dog.count).to eq(count)
        expect(response.body).to include('Dog was successfully updated.')
      end
    end

    describe 'DELETE /dog/1' do
      let(:dog) { create(:dog) }
      it 'destroys a dog' do
        dog.save
        count = Dog.count
        delete dog_path(dog)
        response.status.should be(302)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(Dog.count).to eq(count - 1)
      end
    end
  end
end
