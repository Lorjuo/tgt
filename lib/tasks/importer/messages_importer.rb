# rails c
# Message.all.each{|message| message.destroy}

# TODO: import creation date

module MessagesImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import messages
  def import_messages
    puts "Importing messages..."
    use_old_database

    messages = ActiveRecord::Base.connection.execute('
      SELECT message.id, message.title, message.content, message.date, department.name AS department FROM message LEFT JOIN department ON message.department = department.id
      ')

    use_new_database
    import_counter = 0
    for i in 0...messages.count do
      row = messages.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if message exists already
      message = Message.where(name: row.get("title"), content: row.get("content"))

      # Reload message / Avoid caching problems
      message.reload

      if message.empty?
        department = Department.where(name: row.get("department")).first
        department_id = department.present? ? department.id : Department.where(:name => "generic").first.id

        message = Message.new(name: row.get("title"), 
                        content: row.get("content"), 
                        department_id: department_id, 
                        created_at: row.get("date"), 
                        updated_at: row.get("date"))
        begin
          message.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("title")}\": #{e.message}"
        else
          import_counter+=1
        end
      end
    end
    puts "... imported #{import_counter} messages"
  end
 
end