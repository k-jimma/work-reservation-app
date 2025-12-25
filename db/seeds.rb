# db/seeds.rb
u = User.find_or_create_by!(email: "test@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "テストユーザー" if user.respond_to?(:name)
end

labels   = ["東京都新宿区", "大阪市北区", "京都市中京区", "札幌市中央区"]
prices   = [8000, 12000, 15000]

3.times do |i|
  Room.find_or_create_by!(user: u, name: "テスト物件#{i+1}") do |r|
    r.description = "サンプルの説明文です。#{i+1}"
    r.price       = prices.sample
    r.address     = labels.sample
  end
end

puts "Seed completed. Users=#{User.count}, Rooms=#{Room.count}"
