# frozen_string_literal: true

require "spec_helper"

describe "participatory space", type: :view do
  let(:organization) { create :organization }

  it "respond to participatory_spaces with an empty set" do
    expect(Decidim.find_participatory_space_manifest(:calendar).participatory_spaces.call(organization)).to be_a_kind_of(ActiveRecord::Relation)
    expect(Decidim.find_participatory_space_manifest(:calendar).participatory_spaces.call(organization)).to be_blank
  end
end
