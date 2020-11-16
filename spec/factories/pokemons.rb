FactoryBot.define do
  factory :pokemon do
    name { 'Bulbassauro' }
    base_experience { 64 }
    image_path { 'https://dummy.url/path_to_image.png' }
  end
end
