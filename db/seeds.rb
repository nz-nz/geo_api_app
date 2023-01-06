# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Geolocation.destroy_all

Geolocation.create([
                     {
                       address: 'moda.com',
                       ip: '217.182.69.206',
                       longitude: 7.743750095367432,
                       latitude: 48.58293151855469
                     },
                     {
                       address: 'google.com',
                       ip: '142.250.81.206',
                       longitude: -77.38275909423828,
                       latitude: 38.98371887207031
                     },
                     {
                       address: 'facebook.com',
                       ip: '31.13.66.35',
                       longitude: -77.38275909423828,
                       latitude: 38.98371887207031
                     },
                     {
                       address: 'amazom.com',
                       ip: '3.33.139.32',
                       longitude: -74.6622085571289,
                       latitude: 40.37825012207031
                     }
                   ])
Rails.logger.debug { "Created #{Geolocation.count} Geolocation seeds" }
