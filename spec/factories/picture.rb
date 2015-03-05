include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :picture do
    my_work_id 1
    image { fixture_file_upload(Rails.root.join('spec/fixtures/hat.jpg'), 'image/png') }
    cropped false
  end
end
