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

require 'test_helper'

class CanonicalMetadatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
