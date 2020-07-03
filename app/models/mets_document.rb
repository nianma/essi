class METSDocument
  include MetsStructure
  attr_reader :source_file

  def initialize(mets_file)
    @source_file = mets_file
    @mets = File.open(@source_file) { |f| Nokogiri::XML(f) }
  end

  def record_id
    @mets.xpath("/mets/@ID").text
  end

  def ark_id
    @mets.xpath("/mets/@OBJID").text
  end

  def bib_id
    @mets.xpath("/mets/dmdSec/mdRef/href") \
         .to_s.gsub(/.*\//, '')
  end

  def collection_slugs
    @mets.xpath("/mets/structMap[@TYPE='RelatedObjects']" \
                "//div[@TYPE='IsPartOf']/@CONTENTIDS").to_s
  end

  #def pudl_id
  #  # not used in essi according to Nick
  #  @mets.xpath("/mets:mets/mets:metsHdr/mets:metsDocumentID")
  #       .first.content.gsub(/\.mets/, '')
  #end

  #def title
  #  # default title is the ID
  #  @mets.xpath("/mets/@ID").to_s
  #end

  def thumbnail_path
    xp = "/mets/fileSec/fileGrp[@USE='thumbnail']" \
    "/file/FLocat/href"
    @mets.xpath(xp).to_s.gsub(/file:\/\//, '')
  end

  def viewing_direction
    right_to_left ? "right-to-left" : "left-to-right"
  end

  def right_to_left
    @mets.xpath("/mets/structMap[@TYPE='Physical']/div/@TYPE") \
         .to_s.start_with? 'RTL'
  end

  def multi_volume?
    volume_nodes.length > 1
  end

  def volume_ids
    volume_nodes.map do |vol|
      vol.attribute("ID").value
    end
  end

  def label_for_volume(volume_id)
    volume_node = volume_nodes.find do |vol|
      vol.attribute("ID").value == volume_id
    end
    return volume_node.attribute("LABEL").value if volume_node
  end

  def files_for_volume(volume_id)
    @mets.xpath("//div[@ID='#{volume_id}']//fptr/@FILEID") \
         .map do |file_id|
      file_info(@mets.xpath("//file[@ID='#{file_id.value}']"))
    end
  end

  def files
    @mets.xpath("/mets/fileSec/fileGrp" \
                "/file").map do |f|
      file_info(f)
    end
  end

  def file_info(file)
    {
      id: file.xpath('@ID').to_s,
      checksum: file.xpath('@CHECKSUM').to_s,
      mime_type: file.xpath('@MIMETYPE').to_s,
      path: file.xpath('FLocat/@href').to_s.gsub(/file:\/\//, '')
    }
  end

  def file_opts(file)
    return {} if
      @mets.xpath("count(//div/fptr[@FILEID='#{file[:id]}'])") \
           .to_i.positive?
    { viewing_hint: 'non-paged' }
  end

  def decorated_file(f)
    IoDecorator.new(File.open(f[:path]),
                    f[:mime_type],
                    File.basename(f[:path]))
  end

  private

    def volume_nodes
      xp = "/mets/structMap[@TYPE='Physical']" \
      "/div[@TYPE='MultiVolumeSet']/div"
      @volume_nodes ||= @mets.xpath(xp)
    end
end
