module AreasImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import areas
  def import_areas
    puts "Importing areas..."
    use_old_database

    areas = ActiveRecord::Base.connection.execute('
      SELECT id, name FROM area
      ')

    use_new_database
    import_counter = 0
    for i in 0...areas.count do
      row = areas.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if area exists already
      area = Area.where(name: row.get("name"))

      # Reload area / Avoid caching problems
      area.reload

      if area.empty?
        area = Area.new(name: row.get("name")) 
                        #position: row.get("id"))
        begin
          area.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("name")}\": #{e.message}"
          continue
        else
          import_counter+=1
          import_departments(row.get("id"), area)
        end

      else
        import_departments(row.get("id"), area.first)
      end
    end
    puts "... imported #{import_counter} areas"
  end
 
end