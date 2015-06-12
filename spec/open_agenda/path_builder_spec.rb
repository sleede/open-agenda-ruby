require 'spec_helper'

describe OpenAgenda::PathBuilder do
  subject(:path_builder) { described_class.new('/agendas/:slug/uid', ['a-super-slug']) }
  subject(:empty_path_builder) { described_class.new('', '') }

  describe "decompose_path" do
    it { expect(path_builder.decompose_path).to eq(['/agendas/', ':slug', '/uid']) }
    it { expect(empty_path_builder.decompose_path).to eq([]) }
  end

  describe "build" do
    it { expect { path_builder.build }.not_to raise_error }
    it { expect { empty_path_builder.build}.not_to raise_error }

    context "with missing param" do
      before { path_builder.params = [] }
      it { expect { path_builder.build}.to raise_error(StandardError) }
    end
  end
end
