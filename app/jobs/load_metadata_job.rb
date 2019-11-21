class LoadMetadataJob < ApplicationJob
  queue_as :high_priority

  def perform(token)
    canonical_token = CanonicalToken.find_by_token(token)

    data = MetaInspector.new(canonical_token.canonical_url)
    og_data = data.meta_tags['property']
    images_data = {}
    if og_data['og:image'].present?
      images_data = og_data['og:image'].each_with_index.map do |image, index|
        og_image_types = og_data['og:image:type'] || []
        og_image_widths = og_data['og:image:width'] || []
        og_image_heights = og_data['og:image:height'] || []
        og_image_alts = og_data['og:image:alt'] || []
        [
          url: image,
          type: og_image_types[index] || og_image_types[0],
          width: og_image_widths[index] || og_image_widths[0],
          height: og_image_heights[index] || og_image_heights[0],
          alt: og_image_alts[index] || og_image_alts[0],
        ]
      end
    end

    basic_data = {
      url: canonical_token.canonical_url,
      type: (og_data['og:type'] || []).first,
      title: (og_data['og:title'] || []).first,
      images: images_data
    }
    CanonicalMetadatum.create(canonical_token_id: canonical_token.id, metadata: basic_data)
    canonical_token.update status: :done
  rescue => e
    canonical_token.update status: :error
  end
end
