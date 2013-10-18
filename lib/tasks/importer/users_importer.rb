module UsersImporter
 
  # import users
  def import_users
    puts "Importing users..."
    use_import
    users = ActiveRecord::Base.connection.execute('
      SELECT pid, uid, firstname, lastname, mail, isfemale FROM Person
      ')
     
    use_target
    for i in 0...users.count do
      row = users.get_row i
       
      user = User.where(first_name: row.get("firstname"), 
                        last_name: row.get("lastname"),
                        email: row.get("mail"),
                        isfemale: row.get("isfemale"))
      unless user
        user = User.new(first_name: row.get("firstname"), 
                        last_name: row.get("lastname"),
                        email: row.get("mail"),
                        isfemale: row.get("isfemale"))
        begin
          user.save!
        rescue Exception => e
          puts "Failed to save #{row.get("firstname")} #{row.get("lastname")}: #{e.message}"
        end
      end
    end
  end
 
end