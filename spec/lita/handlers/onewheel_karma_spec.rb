require 'spec_helper'

describe Lita::Handlers::OnewheelKarma, lita_handler: true do
  it 'will add one karma' do
    send_message 'a++'
    expect(replies.last).to eq 'a has 1 karma!'
  end
  it 'will add two karma' do
    send_message 'a++'
    send_message 'a++'
    expect(replies.last).to eq 'a has 2 karma!'
  end
  it 'will remove one karma' do
    send_message 'a--'
    expect(replies.last).to eq 'a has -💩 karma!'
  end
end
