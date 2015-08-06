
class ExportHTMLRunner < JobRunner
  include JSONModel

  def self.instance_for(job)
    if job.job_type == "export_html_job"
      self.new(job)
    else
      nil
    end
  end


  def run
    super

    begin 

      RequestContext.open( :repo_id => @job.repo_id) do
        # why does this not work?
        #resource= JSONModel(:resource).find_by_uri(@json.job["source"])
       
        parsed = JSONModel.parse_reference(@json.job["resource_uri"])
        resource = Resource.to_jsonmodel(parsed[:id]) 
        

        @job.write_output("Generating HTML for #{resource["title"]}  ")
        
        obj = URIResolver.resolve_references(resource,
                                                [ "repository", "linked_agents", "subjects", "tree",  "digital_objects"],
                                                { 'rack.input' => "",  'QUERY_STRING' => "" })
        opts = {
          :include_unpublished => true,
          :include_daos => true,
          :use_numbered_c_tags => false 
        }
        
        record = JSONModel(:resource).new(obj) 
        ead = ASpaceExport.model(:ead).from_resource( record, opts)
        target = ASUtils.tempfile("ead_for_html")
        ASpaceExport.stream(ead).each { |x| target.write( x )}
        target.close

        p target.path
        html_file = Ead2Html.new(target.path).to_html
        
        job_file = @job.add_file(html_file)
        html_file.unlink

        job_file

      end
    end


    # resource = Resource.to_jsonmodel(parsed[:id]) 

    # @job.write_output("Generating HTML for #{resource['title']}")
 

    # @json.job['output_file_paths'] = ['/tmp/html.html']
    # p "JSON"
    # p @json

    # Job.find[

    @job.write_output("All done. Enjoy your HTML finding aid!")
  end

end
