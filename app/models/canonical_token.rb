# == Schema Information
#
# Table name: canonical_tokens
#
#  id            :integer          not null, primary key
#  token         :string           not null
#  canonical_url :string
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CanonicalToken < ApplicationRecord
  has_one :canonical_metadatum

  validates :canonical_url, presence: true

  before_create :generate_token

  enum status: [:pending, :done, :error]

  def self.create_or_find_by(url)
    token = Digest::MD5.hexdigest url
    CanonicalToken.find_by_token(token).presence || self.create(canonical_url: url, token: token, status: :pending)
  end

  private

  def generate_token
    self.token = Digest::MD5.hexdigest canonical_url
  end
end
