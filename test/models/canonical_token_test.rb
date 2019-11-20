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

require 'test_helper'

class CanonicalTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
