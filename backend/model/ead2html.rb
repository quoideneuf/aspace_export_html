require 'java'
require 'saxon-xslt'
require 'stringio'


class Ead2Html


  def initialize(source_path, output= nil)  
   @source = source_path
   @xslt = File.read( StaticAssetFinder.new(File.join('stylesheets')).find('as-ead-html.xsl')) 
   # WHAT A HACK! but you can't pass in a URI as a variable? jeezus.  
   filepath =  File.join(ASUtils.find_base_directory, 'stylesheets', 'as-helper-functions.xsl').gsub("\\", "/" )
   @xslt.gsub!('<xsl:include href="as-helper-functions.xsl"/>', "<xsl:include href='#{filepath}'/>" ) 

  end

  def transform
    transformer = Saxon.XSLT(@xslt)
    input = Saxon.XML(File.open(@source))
    output = transformer.transform(input)
  end

  # returns a temp file with the converted PDF
  def to_html
    output = ASUtils.tempfile('ead2html.html') 
    begin 
      output.write(transform.to_s)      
    ensure
      output.close
    end
    output
  end
end
