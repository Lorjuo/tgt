module TrainingUnitsImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import training_units
  def import_training_units(old_training_group_id, new_training_group)
    puts "Importing training_units..."
    use_old_database

    training_units = ActiveRecord::Base.connection.execute(
      "SELECT id, training_group, day, location_summer, location_winter, time_begin, time_end FROM training_unit WHERE training_group = #{old_training_group_id}"
      )

    use_new_database
    import_counter = 0
    for i in 0...training_units.count do
      row = training_units.get_row i
      
      # puts "-import \"#{row.get("title")}\""
      
      # Filter corrupt entries
      next if row.get("day") == 0

      # Check if training_unit exists already
      training_unit = TrainingUnit.where( week_day: row.get("day") % 7, time_begin: row.get("time_begin"), time_end: row.get("time_end")).joins(:training_group).merge(TrainingGroup.where(:id => new_training_group.id))

      # Reload training_unit / Avoid caching problems
      training_unit.reload

      if training_unit.empty?

        training_unit = TrainingUnit.new( week_day: row.get("day") % 7,
                                          time_begin: row.get("time_begin"),
                                          time_end: row.get("time_end"))

        training_unit.training_group_id = new_training_group.id
        begin
          training_unit.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("name")}\": #{e.message}"
          continue
        else
          import_counter+=1
          import_locations(row.get("id"), training_unit)
        end

      else
        import_locations(row.get("id"), training_unit.first)
      end
    end
    puts "... imported #{import_counter} training_units"
  end
 
end