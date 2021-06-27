# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

20.times do
  User.create!(
    first_name: Facker::Name.first_name,
    last_name: Facker::Name.last_name,
    email: Facker::Internet.email,
    password: Facker::Internet.password,
    last_sign_in_ip: Facker::Internet.ip_v4_address
  )
end
