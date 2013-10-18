module TrainersImporter
  # see for caching: http://stackoverflow.com/questions/6934415/prevent-rails-from-caching-results-of-activerecord-query

  # import trainers
  def import_trainers(old_training_group_id, new_training_group)
    puts "Importing trainers..."
    use_old_database

    trainers = ActiveRecord::Base.connection.execute(
      "SELECT trainer.id, firstname, surname, birthday, home, telephone_number, profession, education, disciplines, e_mail, activities
      FROM trainer, training_unit, training_plan, training_group
      WHERE training_group = #{old_training_group_id}
      AND training_unit.training_group = training_group.id
      AND training_plan.training_unit = training_unit.id
      AND training_plan.trainer = trainer.id"
      )

    use_new_database

    import_counter = 0
    for i in 0...trainers.count do
      row = trainers.get_row i
      
      # puts "-import \"#{row.get("title")}\""

      # Check if trainer exists already
      trainer = Trainer.where(first_name: row.get("firstname"), last_name: row.get("surname"))

      # Reload trainer / Avoid caching problems
      trainer.reload

      if trainer.empty?
        trainer = Trainer.new(first_name: row.get("firstname"),
                              last_name: row.get("surname"),
                              birthday: row.get("birthday"),
                              residence: row.get("home"),
                              phone: row.get("telephone_number"),
                              profession: row.get("profession"),
                              education: row.get("education"),
                              disciplines: row.get("disciplines"),
                              email: row.get("e_mail"),
                              activities: row.get("activities"))

        trainer.training_groups << new_training_group
        begin
          trainer.save(:validate => false)
        rescue Exception => e
          puts "Failed to save \"#{row.get("firstname")} #{row.get("surname")}\": #{e.message}"
          continue
        else
          import_counter+=1
        end

      else
        if !trainer.first.training_groups.include?(new_training_group)
          trainer.first.training_groups << new_training_group
        end
      end
    end
    puts "... imported #{import_counter} trainers"
  end
 
end