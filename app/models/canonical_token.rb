# == Schema Information
#
# Table name: canonical_tokens
#
#  id            :integer          not null, primary key
#  token         :string           not null
#  canonical_url :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CanonicalToken < ApplicationRecord
  has_one :canonical_metadatum

  validates :canonical_url, :given_metadata, presence: true

  before_create :generate_token
  after_create :save_canonical_metadata

  attr_accessor :given_metadata

  private

  def generate_token
    self.token = Digest::MD5.hexdigest canonical_url
  end

  def save_canonical_metadata
    CanonicalMetadatum.create(metadata: self.given_metadata, canonical_token_id: id)
  end
end
