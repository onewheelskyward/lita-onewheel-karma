require 'spec_helper'

describe Lita::Handlers::OnewheelKarma, lita_handler: true do
  NEGATIVE_MESSAGE = 'a has -💩 karma!'

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
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end

  it 'will remove lotsa karma' do
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end

  it 'will multiply one karma' do
    send_message 'a++'
    send_message 'a*=2'
    expect(replies.last).to eq 'a has 2 karma!'
  end

  it 'will multiply many karma' do
    send_message 'a++'
    send_message 'a++'
    send_message 'a++'
    send_message 'a++'
    send_message 'a++'
    send_message 'a*=5'
    expect(replies.last).to eq 'a has 25 karma!'
  end

  it 'will multiply many negative karma' do
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a*=5'
    # -25
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end
end
