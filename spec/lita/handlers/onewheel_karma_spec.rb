require 'spec_helper'

describe Lita::Handlers::OnewheelKarma, lita_handler: true do
  def get_negative(num)
    "a has #{RomanNumerals.to_roman(num)}💩 karma!"
  end

  def get_positive(num)
    "a has #{num} karma!"
  end

  it 'will add one karma' do
    send_message 'a++'
    expect(replies.last).to eq get_positive(1)
  end

  it 'will add two karma' do
    send_message 'a++'
    send_message 'a++'
    expect(replies.last).to eq get_positive(2)
  end

  it 'will remove one karma' do
    send_message 'a--'
    expect(replies.last).to eq get_negative(1)
  end

  it 'will remove lotsa karma' do
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    expect(replies.last).to eq get_negative(6)
  end

  it 'will multiply one karma' do
    send_message 'a++'
    send_message 'a*=2'
    expect(replies.last).to eq get_positive(2)
  end

  it 'will multiply many karma' do
    send_message 'a++'
    send_message 'a++'
    send_message 'a++'
    send_message 'a++'
    send_message 'a++'
    send_message 'a*=5'
    expect(replies.last).to eq get_positive(25)
  end

  it 'will multiply many negative karma' do
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a*=5'
    # -25
    expect(replies.last).to eq get_negative(25)
  end

  it 'will add arbitrary karma' do
    send_message 'a+=9'
    expect(replies.last).to eq get_positive(9)
  end

  it 'will add negative arbitrary karma' do
    send_message 'a+=-9'
    expect(replies.last).to eq get_negative(9)
  end

  it 'will subtract arbitrary karma' do
    send_message 'a-=9'
    expect(replies.last).to eq get_negative(9)
  end

  it 'will subtract negative arbitrary karma' do
    send_message 'a-=-9'
    expect(replies.last).to eq get_positive(9)
  end

  it 'will spacing' do
    send_message 'a -= -9'
    expect(replies.last).to eq get_positive(9)
  end

  it 'will spacing 2' do
    send_message 'a += -9'
    expect(replies.last).to eq get_negative(9)
  end

  it 'will spacing 3' do
    send_message 'a ++'
    expect(replies.last).to eq get_positive(1)
  end

  it 'will spacing 4' do
    send_message 'a --'
    expect(replies.last).to eq get_negative(1)
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
    expect(replies.last).to eq get_positive(1)
  end

  it 'midstream karma--s' do
    send_message 'I like big a-- and I cannot lie'
    expect(replies.last).to eq get_negative(1)
  end

  it 'roman numerals' do
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    send_message 'a--'
    expect(replies.last).to include 'a has IV'
  end
end
