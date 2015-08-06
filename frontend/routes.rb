ArchivesSpace::Application.routes.draw do

  match('plugins/export_html' => 'export_html#create', :via => [:post])

  match('plugins/export_html/jobs/:job_id/file/:id(.:format)' => 'export_html#download_file', :via => [:get])


end
