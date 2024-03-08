shared_examples "a component" do
  it "renders a frontend version" do
    expect { render_inline described_class.new(component: component) }.not_to raise_error
  end

  it "renders an admin version" do
    with_variant :admin do
      expect { render_inline described_class.new(component: component) }.not_to raise_error
    end
  end
end
