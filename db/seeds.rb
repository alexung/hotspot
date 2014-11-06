10.times do
  Repository.create(name:Faker::Lorem.word, url: Faker::Internet.url)
end

50.times do
  File.create(name:Faker::Lorem.word, url: Faker::Internet.url)
end

