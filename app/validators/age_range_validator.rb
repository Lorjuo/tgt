class AgeRangeValidator < ActiveModel::Validator
  def validate(record)
    return unless record.age_begin.present? && record.age_end.present?
    unless record.age_begin <= record.age_end || record.age_end == 0
      record.errors[:age_end] << 'Age end has to be higher than Age begin'
    end
  end
end
# class IntenseFilmTitleValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     record.errors[attribute] << "must start with 'The'" unless value =~ /^The/
#   end
# end