# == Schema Information
#
# Table name: jobs_trackers
#
#  id                 :integer          not null, primary key
#  status             :string
#  delayed_job_id     :integer
#  canonical_token_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class JobsTrackerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
