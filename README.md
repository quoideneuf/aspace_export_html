ASpace HTML Export
===========

Run a background job to generate an HTML finding aid from a Resource record's EAD

# Getting Started

Download the latest release from the Releases tab in Github:

  https://github.com/lcdhoffman/aspace_export_html/releases

Unzip it to the plugins directory:

    $ cd /path/to/archivesspace/plugins
    $ unzip /path/to/your/downloaded/aspace_export_html -d aspace_export_html

Enable the plugin by editing the file in `config/config.rb`:

    AppConfig[:plugins] = ['some_plugin', 'aspace_export_html']

(Make sure you uncomment this line (i.e., remove the leading '#' if present))

See also:

  https://github.com/archivesspace/archivesspace/blob/master/plugins/README.md

# Disclaimer

This is a hacked together solution and should be used with caution. Please file an issue
if you encounter any problems.

