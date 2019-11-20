# == Schema Information
#
# Table name: canonical_metadata
#
#  id                 :integer          not null, primary key
#  metadata           :json
#  canonical_token_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class CanonicalMetadatum < ApplicationRecord
  belongs_to :canonical_token

  validates :metadata, :canonical_token_id, presence: true
end
