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

  it 'will add arbitrary karma' do
    send_message 'a+=9'
    expect(replies.last).to eq 'a has 9 karma!'
  end

  it 'will add negative arbitrary karma' do
    send_message 'a+=-9'
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end

  it 'will subtract arbitrary karma' do
    send_message 'a-=9'
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end

  it 'will subtract negative arbitrary karma' do
    send_message 'a-=-9'
    expect(replies.last).to eq 'a has 9 karma!'
  end

  it 'will spacing' do
    send_message 'a -= -9'
    expect(replies.last).to eq 'a has 9 karma!'
  end

  it 'will spacing 2' do
    send_message 'a += -9'
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end

  it 'will spacing 3' do
    send_message 'a ++'
    expect(replies.last).to eq 'a has 1 karma!'
  end

  it 'will spacing 4' do
    send_message 'a --'
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end

  it 'uri tests' do
    send_message 'http://www.oregonlive.com/history/2015/07/throwback--thursday-portlands_j.html'
    expect(replies.last).to eq nil
  end

  it 'uri tests' do
    send_message 'http://www.oregonlive.com/history/2015/07/throwback++thursday-portlands_j.html'
    expect(replies.last).to eq nil
  end

  it 'midstream karmas' do
    send_message 'I like big a++ and I cannot lie'
    expect(replies.last).to eq 'a has 1 karma!'
  end

  it 'midstream karma--s' do
    send_message 'I like big a-- and I cannot lie'
    expect(replies.last).to eq NEGATIVE_MESSAGE
  end
end
