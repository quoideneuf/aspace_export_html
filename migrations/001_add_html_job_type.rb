require 'db/migrations/utils'

Sequel.migration do
  up do
    puts "Adding HTML export job type to enumeration"
    enum = self[:enumeration].filter(:name => 'job_type').select(:id).first[:id]

    counter = self[:enumeration_value].filter(:enumeration_id => enum).order(:position).select(:position).last[:position]

    unless self[:enumeration_value].filter(:enumeration_id => enum, :value => 'export_html_job').count > 0
      self[:enumeration_value].insert( :enumeration_id  => enum, :value => 'export_html_job', :readonly => 0, :position => counter + 1)
    end

  end

  down do
  end

end
