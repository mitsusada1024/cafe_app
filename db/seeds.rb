User.create!(name:  "kouki",
             email: "kouki06181024@gmail.com",
             password:              "04lim6275",
             password_confirmation: "04lim6275",
             admin: true, activated: true, activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, activated: true, activated_at: Time.zone.now)
end