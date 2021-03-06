# frozen_string_literal: true

describe Facts::Solaris::SystemUptime::Seconds do
  describe '#call_the_resolver' do
    subject(:fact) { Facts::Solaris::SystemUptime::Seconds.new }

    let(:value) { 3600 }

    before do
      allow(Facter::Resolvers::Uptime).to receive(:resolve).with(:seconds).and_return(value)
    end

    it 'calls Facter::Resolvers::Uptime' do
      fact.call_the_resolver
      expect(Facter::Resolvers::Uptime).to have_received(:resolve).with(:seconds)
    end

    it 'returns minutes since last boot' do
      expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'system_uptime.seconds', value: value)
    end
  end
end
