class Record < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_one_attached :image
  has_one_attached :file
  validate :correct_file_type

  after_save :dwg_to_img, if: -> { file.attached? }

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  def tag_list
    self.tags.map(&:name).join(", ")
  end

  private

  def correct_file_type
    if file.attached? && !file.content_type.in?(%w(application/acad application/x-acad application/autocad_dwg image/vnd.dwg application/dwg application/x-dwg))
      errors.add(:file, 'must be a DWG file')
    end
  end

  private

  def dwg_to_img
    if file.attached?
      temp_file = Tempfile.new([file.filename.base, file.filename.extension])
      temp_file.binmode
      temp_file.write(file.download)
      temp_file.rewind

      Rails.logger.info "Using DWG file: #{temp_file.path}"

      image_path = Rails.root.join("tmp", "output_image.png")
      Rails.logger.info "Image output path: #{image_path}"

      venv_python = 'C:/Users/Viktor/Desktop/py/dwgconvert/.venv/Scripts/python.exe'
      command = "#{venv_python} #{Rails.root.join('lib/scripts/dwg_to_img.py')} #{temp_file.path} #{image_path}"
      Rails.logger.info "Running command: #{command}"

      if system(command)
        if File.exist?(image_path)
          image.attach(io: File.open(image_path), filename: "output_image.png", content_type: "image/png")
        else
          Rails.logger.error "Image file was not created"
        end
      else
        Rails.logger.error "Python script failed with status: #{$?.exitstatus}"
      end

      temp_file.close
      temp_file.unlink # Delete the temp file
    else
      Rails.logger.error "DWG file not attached"
    end
  end



end
