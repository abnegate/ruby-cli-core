RSpec.describe Cli::Core do
  it "has a version number" do
    expect(Cli::Core::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
