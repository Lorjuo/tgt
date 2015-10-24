class AddTermsToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :term_training_group, :string, default: 'Gruppe'
    add_column :departments, :term_training_groups, :string, default: 'Gruppen'
    add_column :departments, :term_competition, :string, default: 'Veranstaltung'
    add_column :departments, :term_competitions, :string, default: 'Veranstaltungen'
    add_column :departments, :term_trainer, :string, default: 'Betreuer'
    add_column :departments, :term_trainers, :string, default: 'Betreuer'
    add_column :departments, :term_athlet, :string, default: 'Teilnehmer'
    add_column :departments, :term_athlets, :string, default: 'Teilnehmer'
    add_column :departments, :term_training_unit, :string, default: 'Termin'
    add_column :departments, :term_training_units, :string, default: 'Termine'
  end
end
