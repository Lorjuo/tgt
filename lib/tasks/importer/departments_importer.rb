module DepartmentsImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import departments
  def import_departments#(old_area_id, new_area)
    puts "Importing departments..."
    use_old_database

    # TODO: Add remaining columns
    departments = ActiveRecord::Base.connection.execute(
      #{}"SELECT id, name FROM department WHERE area = #{old_area_id}"
      "SELECT id, name FROM department"
      )

    use_new_database
    import_counter = 0
    for i in 0...departments.count do
      row = departments.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if department exists already
      department = Department.where(name: row.get("name"))

      # Reload department / Avoid caching problems
      department.reload

      if department.empty?
        department = Department.new(name: row.get("name"))
        #department.area_id = new_area.id
        begin
          department.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("name")}\": #{e.message}"
          continue
        else
          import_counter+=1
          import_training_groups(row.get("id"), department)
        end

      else
        import_training_groups(row.get("id"), department.first)
      end
    end
    puts "... imported #{import_counter} departments"
  end
 
end