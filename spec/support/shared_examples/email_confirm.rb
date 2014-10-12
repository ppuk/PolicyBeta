
shared_examples_for 'email confirmable' do
  subject { described_class.new(email: 'test@example.com') }

  describe '#confirmed_email' do
    it 'should only include instances with confirmed emails' do
      expect(described_class.confirmed_email.where_values.first.left.name).to eql('email_confirmed_on')
      expect(described_class.confirmed_email.where_values.first.right).to be_nil
      expect(described_class.confirmed_email.where_values.first).to be_a(Arel::Nodes::NotEqual)
    end
  end

  describe '#unconfirmed_email' do
    it 'should only include instances with confirmed emails' do
      expect(described_class.unconfirmed_email.where_values.first.left.name).to eql('email_confirmed_on')
      expect(described_class.unconfirmed_email.where_values.first.right).to be_nil
      expect(described_class.unconfirmed_email.where_values.first).to be_a(Arel::Nodes::Equality)
    end
  end

  describe 'on create' do
    it 'should callback to init the confirmation token' do
      expect(subject).to receive(:generate_email_confirmation_token).once
      subject.run_callbacks(:create)
    end
  end

  describe '.generate_confirmation_token' do
    it 'should create the confirmation token' do
      expect(subject.email_confirmation_token).to be_nil
      subject.generate_email_confirmation_token

      expect(subject.email_confirmation_token).not_to be_blank
      expect(subject.email_confirmation_token.length).to eql(40)
    end
  end

  describe '.confirm!' do
    it 'should update the confirmed date' do
      Timecop.freeze do
        expect(subject).
          to receive(:update_column).
          with(:email_confirmed_on, Time.now.utc).
          and_return(true)
        subject.confirm_email!
      end
    end
  end

  describe '.email_confirmed?' do
    context 'when confirmed' do
      before(:each) do
        allow(subject).to receive(:email_confirmed_on).and_return(Time.now.utc)
      end

      it 'should return true' do
        expect(subject.email_confirmed?).to be_truthy
      end
    end

    context 'when not confirmed' do
      before(:each) do
        allow(subject).to receive(:email_confirmed_on).and_return(nil)
      end

      it 'should return false' do
        expect(subject.email_confirmed?).to be_falsey
      end
    end
  end

end
