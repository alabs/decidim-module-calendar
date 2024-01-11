# frozen_string_literal: true

require "spec_helper"

describe "participatory space", type: :view do
  let(:organization) { create(:organization) }
  let(:manifest) { Decidim.find_participatory_space_manifest(:calendar) }

  it "respond to participatory_spaces with an empty set" do
    expect(manifest.participatory_spaces.call(organization)).to be_a(ActiveRecord::Relation)
    expect(manifest.participatory_spaces.call(organization)).to be_blank
  end

  it "responds to where method as it was an ActiveRecord" do
    expect(manifest.model_class_name.constantize.where(something: :anything)).to be_blank
  end
end
