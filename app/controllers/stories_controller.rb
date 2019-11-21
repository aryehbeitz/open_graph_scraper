class StoriesController < ApplicationController
  def index
    url = url_safe_param

    data = MetaInspector.new(url)
    canonicals = data.canonicals.first
    canonical_url = canonicals.present? && canonicals[:href].presence || data.meta_tags['property']['og:url']&.first || url

    canonical_token = CanonicalToken.create_or_find_by(canonical_url)

    # in this case, since we already loaded the html for
    # the canonical_url, we could have just scraped
    # everything now, but for order's sake, we'll
    # imagine it takes longer and send it to a job
    # when a token is given

    render json: {
      given_url: url,
      found_canonical_url: canonical_url,
      token: canonical_token.token
    }
  rescue => e
    render json: { error: e.message }
  end

  def show
    token = token_id_safe_param
    canonical_token = CanonicalToken.find_by_token(token)

    if canonical_token.nil?
      render json: { error: 'cannot find entry with given token' }
      return
    end

    if canonical_token.status == 'done' && canonical_token.canonical_metadatum.present?
      metadata_obj = canonical_token.canonical_metadatum
      render json: metadata_obj.metadata.merge(
        id: metadata_obj.id,
        updated_time: metadata_obj.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%L%z'),
        scrape_status: canonical_token.status
      )
      return
    end

    LoadMetadataJob.perform_now(canonical_token.token)

    render json: {
      id: canonical_token.id,
      scrape_status: canonical_token.status
    }
  end

  private

  def url_safe_param
    params.require(:url)
  end

  def token_id_safe_param
    params.require(:id)
  end
end
