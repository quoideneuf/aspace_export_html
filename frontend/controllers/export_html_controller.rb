
class ExportHtmlController < ApplicationController

  set_access_control "view_repository" => [:new, :create, :download_file]

  include ExportHelper

  def create

    resource_uri = "/repositories/#{session[:repo_id]}/resources/#{params[:resource_id]}"

    export_job = JSONModel(:export_html_job).from_hash({
                                                         'jsonmodel_type' => 'export_html_job',
                                                         'resource_uri' => resource_uri
                                                                            })

    job = JSONModel(:job).from_hash({
                                      :job_type => "export_html_job",
                                      :job => export_job
                                    })

    job.save

    render :json => job
  end


  def download_file
    url = "/repositories/#{JSONModel::repository}/jobs/#{params[:job_id]}/output_files/#{params[:id]}"

    stream_params = {
      :filename => "job_#{params[:job_id].to_s}_file_#{params[:id].to_s}.html",
      :content_type => "text/html"
    }

    stream_file(url, stream_params)

  end


  private

  def stream_file(request_uri, params = {})
    respond_to do |format|
      format.html {
        self.response.headers["Content-Type"] = params[:content_type]
        self.response.headers["Content-Disposition"] = "attachment; filename=#{params[:filename]}"
        self.response.headers['Last-Modified'] = Time.now.ctime.to_s

        self.response_body = Enumerator.new do |y|
          xml_response(request_uri, params) do |chunk, percent|
            y << chunk if !chunk.blank?
          end
        end
      }
    end
  end
end
