include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :picture do
    image { fixture_file_upload(Rails.root.join('spec/fixtures/hat.jpg'), 'image/png') }
    cropped false
  end
end
