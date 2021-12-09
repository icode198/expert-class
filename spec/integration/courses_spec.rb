require 'swagger_helper'

TAGS_COURSE = 'Courses'.freeze

describe 'Courses API' do
  let!(:courses) { create_list(:course, 5) }
  let!(:image_url) { "https://res.cloudinary.com/starsheriff/image/upload/#{Faker::Lorem.characters(number: 10)}.jpeg" }

  # let!(:course_id) { courses.first.id }
  # let!(:deleted_course) { courses.first }
  let!(:user) { create(:user) }
  let!(:existing_username) { { user: { username: user.username } } }

  # Stub cloudinary related methods
  before do
    allow_any_instance_of(Course).to receive(:attach_image)
    allow_any_instance_of(Course).to receive(:course_image_url).and_return(image_url)
  end

  before { post '/api/v1/sign_in', params: existing_username }

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end

  path '/api/v1/courses' do
    get 'returns list with all courses' do
      tags TAGS_COURSE
      produces 'application/json'

      response '200', 'success' do
        schema type: :array
        run_test!
      end
    end
  end
end
