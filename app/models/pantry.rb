class Pantry < ActiveRecord::Base
  attr_accessible :name, :pasta, :remote_image_url
  mount_uploader :pasta, PastaUploader

  after_save :enqueue_image

  def pasta_name
    File.basename(pasta.path || pasta.filename) if pasta
  end

  def enqueue_image
    ImageWorker.perform_async(id, key) if key.present?
  end

  class ImageWorker
    include Sidekiq::Worker

    def perform(id, key)
      pantry = Pantry.find(id)
      pantry.key = key
      pantry.remote_image_url = pantry.image.direct_fog_url(with_path: true)
      pantry.save!
      pantry.update_column(:pasta_processed, true)
    end
  end
end

