namespace :populate do
  desc "Database custom drop"
  task :faq  => :environment do
    puts "="*80
    puts 'creating faq'
    puts "="*80
    5.times do |i|
      innerds = {question: Faker::Lorem.sentence(5, false, 4), answer: Faker::Lorem.paragraph(10, true, 4)}
      puts "faq: #{i+1} --- #{innerds}"
      Faq.create(innerds)
    end
  end

end