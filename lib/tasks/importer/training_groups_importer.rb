module TrainingGroupsImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import training_groups
  def import_training_groups(old_department_id, new_department)
    puts "Importing training_groups..."
    use_old_database

    training_groups = ActiveRecord::Base.connection.execute(
      "SELECT id, name, age_begin, age_end, department, description, ancient FROM training_group WHERE department = #{old_department_id}"
      )

    use_new_database
    import_counter = 0
    for i in 0...training_groups.count do
      row = training_groups.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if training_group exists already
      training_group = TrainingGroup.where( name: row.get("name")).joins(:department).merge(Department.where(:id => new_department.id))

      # Reload training_group / Avoid caching problems
      training_group.reload

      if training_group.empty?
        training_group = TrainingGroup.new( name: row.get("name"),
                                            age_begin: row.get("age_begin"),
                                            age_end: row.get("age_end"),
                                            description: row.get("description"),
                                            ancient: row.get("ancient"))

        training_group.department_id = new_department.id
        begin
          training_group.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("name")}\": #{e.message}"
          continue
        else
          import_counter+=1
          import_trainers(row.get("id"), training_group)
          import_training_units(row.get("id"), training_group)
        end

      else
        import_trainers(row.get("id"), training_group.first)
        import_training_units(row.get("id"), training_group.first)
      end
    end
    puts "... imported #{import_counter} training_groups"
  end
 
end