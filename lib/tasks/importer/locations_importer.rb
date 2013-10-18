module LocationsImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import locations
  def import_locations(old_training_unit_id, new_training_unit)
    puts "Importing locations..."
    use_old_database

    locations = ActiveRecord::Base.connection.execute(
      "SELECT location.id, name, location_summer, location_winter FROM location, training_unit
      WHERE training_unit.id = #{old_training_unit_id}
      AND ( training_unit.location_summer = location.id
        OR training_unit.location_winter = location.id )"
      )

    use_new_database

    training_unit = TrainingUnit.find(new_training_unit.id)
    
    import_counter = 0
    for i in 0...locations.count do
      row = locations.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if location exists already
      location = Location.where( name: row.get("name"))

      # Reload location / Avoid caching problems
      location.reload

      if location.empty?

        location = Location.new(name: row.get("name"))

        if row.get("id") == row.get("location_summer")
          training_unit.location_summer_id = location.id
          training_unit.save
        end
        if row.get("id") == row.get("location_winter")
          training_unit.location_winter_id = location.id
          training_unit.save
        end

        begin
          location.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("name")}\": #{e.message}"
          continue
        else
          import_counter+=1
        end

      else
        if row.get("id") == row.get("location_summer")
          training_unit.location_summer_id = location.first.id
          training_unit.save
        end
        if row.get("id") == row.get("location_winter")
          training_unit.location_winter_id = location.first.id
          training_unit.save
        end
      end
    end
    puts "... imported #{import_counter} locations"
  end
 
end