module ProjectsImporter
 
  # import projects
  def import_projects
    puts "Importing projects..."
    use_import
    projects = ActiveRecord::Base.connection.execute('
      SELECT wid, headline, text_facts, text_long_facts, pub_date, hyperlink FROM work
      ')
     
    use_target
    for i in 0...projects.count do
      row = projects.get_row i
       
      project = Project.where(title: row.get("headline"), 
                        teaser: row.get("text_facts"),
                        published_at: row.get("pub_date"))
      unless project
        project = Project.new(title: row.get("headline"), 
                              teaser: row.get("text_facts"),
                              description: row.get("text_long_facts"),
                              published_at: row.get("pub_date"),
                              link: row.get("hyperlink"))
        begin
          project.save!
        rescue Exception => e
          puts "Failed to save #{row.get("title")} #{row.get("published_at")}: #{e.message}"
        end
      end
    end
  end
 
end