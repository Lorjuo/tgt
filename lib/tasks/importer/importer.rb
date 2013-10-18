Dir[File.dirname(__FILE__) + "/*.rb"].each {|file| require file }
 
class Importer
 
  # include sub-modules
  include UsersImporter
  include ProjectsImporter
  include MessagesImporter
  include AreasImporter
  include DepartmentsImporter
  include LocationsImporter
  include TrainingGroupsImporter
  include TrainersImporter
  include TrainingUnitsImporter
 
  # initializer for a new importer
  def initialize new, old
    # feedback for the programmer
    puts "Importing from #{old} to {new}"
 
    @newDb = new
    @oldDb = old
  end
 
  # execute the import
  def execute
     
    # if you do not like to import data, if the new database
    # already contains data, just a security hint..
    #if User.count > 0
      #raise "Import aborted! There already are users in the database."
    #end
     
    #if Project.count > 0
    # ..and so on..
    #####
     
    # call sub-importer modules
    #import_users
    #import_projects
    #import_areas
    import_departments
    import_messages
  end
 
  # later in the import process you have to switch beween
  # the old and the new database.
 
  # use new database (= switch to new database)
  def use_new_database
    ActiveRecord::Base.connection.execute("use #{@newDb}")
  end
 
  # use old database (= switch to old database)
  def use_old_database
    ActiveRecord::Base.connection.execute("use #{@oldDb}")
  end
 
end

# custom mysql row to facilite access
class Row
  def initialize fields, values
    @fields = fields
    @values = values
  end
 
  def get field
    @values[@fields.index(field)]
  end
end
 
# Add get_row method to Mysql2::Result class
class Mysql2::Result
  def get_row index
    Row.new self.fields, self.to_a[index].to_a
  end
end