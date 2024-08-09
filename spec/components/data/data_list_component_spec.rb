# frozen_string_literal: true

require "rails_helper"

RSpec.describe Data::DataListComponent, type: :component do
  it "renders something useful" do
    expect(
      render_inline(described_class.new([{ name: "Hello world", value: "Foo bar" }])).to_html
    ).to include(
      "Hello world"
    )
  end
end
