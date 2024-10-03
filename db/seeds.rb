# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.first.disaster_notifications.create([
  { title: "東京で地震", content: "震度5.5の地震が発生しました。", disaster_type: "地震", latitude: 35.6895, longitude: 139.6917 },
  { title: "大阪で洪水", content: "大阪で大雨による洪水が発生しています。", disaster_type: "洪水", latitude: 34.6937, longitude: 135.5023 }
])