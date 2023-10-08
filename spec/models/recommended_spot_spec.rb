require 'rails_helper'

RSpec.describe RecommendedSpot, type: :model do
  it "タイトルとユーザーIDと住所があれば投稿できる" do
    expect(FactoryBot.build(:recommended_spot)).to be_valid
  end

  it "タイトルがなければ投稿できない" do
    expect(FactoryBot.build(:recommended_spot, name: "")).to be_invalid
  end

  it "ユーザーIDがなければ投稿できない" do
    expect(FactoryBot.build(:recommended_spot, user_id: "")).to be_invalid
  end

  it "住所がなければ投稿できない" do
    expect(FactoryBot.build(:recommended_spot, address: "")).to be_invalid
  end
end
