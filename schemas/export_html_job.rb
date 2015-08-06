{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
      "resource_uri" => {
        "type" => "string",
        "ifmissing" => "error"
      }
    }
  }
}
