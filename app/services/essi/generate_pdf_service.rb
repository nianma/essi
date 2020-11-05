require "open-uri"

module ESSI
  class GeneratePdfService
    # Generate PDFs for download
    def initialize(resource)
      @resource = resource
      @file_name = "#{@resource.id}.pdf"
    end

    def generate
      file_path = create_pdf_file_path
      generate_pdf_document(file_path)

      { file_path: file_path, file_name: @file_name }
    end

    private

    def dir_path
      Rails.root.join('tmp', 'pdfs')
    end

    def create_pdf_file_path
      file_path = dir_path.join(@file_name)

      FileUtils.mkdir_p(dir_path) unless Dir.exist?(dir_path)
      File.delete(file_path) if File.exist?(file_path)
      file_path
    end

    def generate_pdf_document(file_path)
      Prawn::Document.generate(file_path, margin: [0, 0, 0, 0]) do |pdf|
        CoverPageGenerator.new(@resource).apply(pdf)
        create_tmp_files(pdf)
      end
    end

    def create_tmp_files(pdf)
      sorted_files = @resource.ordered_members.to_a
      sorted_files.each.with_index(1) do |fs, i|
        Tempfile.create(fs.original_file.file_name.first, dir_path) do |file|
          page_size = [CoverPageGenerator::LETTER_WIDTH, CoverPageGenerator::LETTER_HEIGHT]
          file.binmode
	  write_iiif_file(file, fs)
		
          pdf.image(file, fit: page_size, position: :center, vposition: :center)
        end
        paginate_images(pdf, i)
      end
    end

    def write_iiif_file(file, fs)
	#while using iiif_image_url_builder.call, both the following cases work,
	#but you cannot set nil for the second parameter. 
	#To make downloading work, you also need make changes to essi_config.example.yml, 
	#you can either set cantaloupe iiif_server_url: http://localhost:3000/iiif/2/, 
	#or totally comment out the configuration for cantaloupe.
	#One thing need to investigate is, although it shows the downloading completed in the log,
	#but the browser has time out error when downloading at the first time,
	#you have to refresh to view the downloading pdfs. .

	url=Hyrax.config.iiif_image_url_builder.call(fs.original_file.id, "/", '800,')
	#url=Hyrax.config.iiif_image_url_builder.call(fs.original_file.id, "localhost:3000/", '800,')
	file.write open(url).read
    end

    def paginate_images(pdf, i)
      num_of_images = @resource.file_sets.count
      pdf.start_new_page unless num_of_images == i
    end
  end
end
