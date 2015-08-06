

require 'spec_helper'
require_relative 'factories'


describe "Export HTML Jobs" do

  let(:job) do
    resource = create(:json_resource)

    child1 = create(:json_archival_object,
                    :resource => {'ref' => resource.uri},
                    :title => "Child 1")


    json = build(:json_job,
                 :job_type => 'export_html_job',
                 :job => build(:json_export_html_job, :resource_uri => resource.uri)
                 )

    user = create_nobody_user
    job = Job.create_from_json(json,
                               :repo_id => $repo_id,
                               :user => user)

    job
  end    


  it "can create a job for exporting html" do
    job.should_not be(nil)
    job.job_type.should eq('export_html_job')
    job.owner.username.should eq('nobody')
  end


  it "can run a job and get the path to the HTML file(s)" do
    runner = JobRunner.for(job)
    runner.run
    JobFile.filter( :job_id => job.id ).count.should eq(1)

    job_file = JobFile.filter( :job_id => job.id).first

    html = IO.read(job_file[:file_path])

    html.should match(/<h1>Resource Title/)
  end

end
