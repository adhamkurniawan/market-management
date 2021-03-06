# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(name: 'Adham Kurniawan', email: 'admin@admin.com', password: 'password', password_confirmation: 'password', admin: true)
admin.skip_confirmation_notification!
admin.save!
categories = Category.create([{name: 'Fruits', user_id: 1}, {name: 'Vegetables', user_id: 1}])
