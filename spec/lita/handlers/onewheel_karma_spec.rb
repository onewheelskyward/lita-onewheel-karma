require 'spec_helper'

describe Lita::Handlers::OnewheelKarma, lita_handler: true do
  it 'will add one karma' do
    send_message 'a++'
    expect(replies.last).to eq 'a has 1 karma!'
  end
end
