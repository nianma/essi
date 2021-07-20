# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rake'

# When db:seed is run in same rake process as db:migrate column information is outdated.
ActiveRecord::Base.descendants.each(&:reset_column_information)

Rake::Task['hyrax:default_collection_types:create'].invoke
Rake::Task['hyrax:default_admin_set:create'].invoke

# Import a flexible metadata profile
AllinsonFlex::Importer.load_profile_from_path(path: Rails.root.join('config', 'metadata_profile', 'essi_short.yaml').to_s) unless AllinsonFlex::Profile.any?

collection_types = Hyrax::CollectionType.all
collection_types.each do |c|
  next unless c.title =~ /^translation missing/
  oldtitle = c.title
  c.title = I18n.t(c.title.gsub("translation missing: en.", ''))
  c.save
  puts "#{oldtitle} changed to #{c.title}"
end
