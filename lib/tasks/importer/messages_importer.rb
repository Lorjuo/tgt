module MessagesImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import messages
  def import_messages
    puts "Importing messages..."
    use_old_database

    messages = ActiveRecord::Base.connection.execute('
      SELECT id, title, content FROM message
      ')

    use_new_database
    import_counter = 0
    for i in 0...messages.count do
      row = messages.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if message exists already
      message = Message.where(headline: row.get("title"))

      # Reload message / Avoid caching problems
      message.reload

      if message.empty?
        message = Message.new(headline: row.get("title"), 
                        content: row.get("content"))
        begin
          message.save!
        rescue Exception => e
          puts "Failed to save \"#{row.get("headline")}\": #{e.message}"
        else
          import_counter+=1
        end
      end
    end
    puts "... imported #{import_counter} messages"
  end
 
end