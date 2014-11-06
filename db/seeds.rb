10.times do
  Repository.create(name:Faker::Lorem.word, url: Faker::Internet.url)
end

50.times do
  Doc.create(name:Faker::Lorem.word, url: Faker::Internet.url, repository_id: (1..10).to_a.sample)
end

