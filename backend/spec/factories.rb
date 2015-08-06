require 'factory_girl'

FactoryGirl.define do

  factory :json_export_html_job, class: JSONModel(:export_html_job) do
    resource_uri "/repositories/2/resources/1"
  end


end
