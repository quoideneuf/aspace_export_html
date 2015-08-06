# not in love with this - need a better API for adding job types
# via a plugin - or just a better deep_merge function in ASUtils
JOB_TYPES ||= [
             {"type" => "JSONModel(:import_job) object"},
             {"type" => "JSONModel(:find_and_replace_job) object"},
             {"type" => "JSONModel(:print_to_pdf_job) object"}
            ]

JOB_TYPES << {"type" => "JSONModel(:export_html_job) object"}

{"job" => {
    "type" => JOB_TYPES
  }
}
