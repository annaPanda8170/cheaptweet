require 'rails_helper'

RSpec.feature "CheapTweets", type: :feature do
  scenario "新規登録するとログアウトが表示されているTOP画面に遷移する" do
    visit root_path
    click_link "会員登録"
    fill_in "user_nickname", with: "annaPanda"
    fill_in "user_email", with: "a@a"
    fill_in "user_password", with: "111111"
    fill_in "user_password_confirmation", with: "111111"
    click_button "Sign up"
    expect(page).to have_content 'ログアウト'
  end
  scenario "ログインするとログアウトが表示されているTOP画面に遷移する" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "user_email", with: "a1@a"
    fill_in "user_password", with: "111111"
    click_button "Log in"
    expect(page).to have_content 'ログアウト'
  end
  scenario "非ログイン状態でTOP画面に遷移するとログアウトが表示されていない" do
    visit root_path
    expect(page).not_to have_content 'ログアウト'
  end
  scenario "投稿したらデータベースにtweetが一つ増える" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    expect{
      click_link "投稿"
      fill_in "tweet_text", with: "こんにちは"
      click_button "投稿"
    }.to  change( Tweet.all, :count ).by(1)
  end
  scenario "自分で投稿したtweetをshowして編集するとindexに反映される" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_link "投稿"
    fill_in "tweet_text", with: "こんにちは"
    click_button "投稿"
    click_link "こんにちは"
    click_link '編集'
    fill_in "tweet_text", with: "こんにちは！"
    click_button '編集'
    visit root_path
    expect(page).to have_content 'こんにちは！'
  end
  scenario "自分以外が投稿したtweetをshowすれば編集ボタンが表示されない" do
    tweet = FactoryBot.create(:tweet)
    visit root_path
    click_link "a"
    expect(page).not_to have_content '編集'
  end
  scenario "自分で投稿したtweetをshowして削除ボタンを押せばデータベースのtweetが一つ減る" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_link "投稿"
    fill_in "tweet_text", with: "こんばんは"
    click_button "投稿"
    click_link "こんばんは"
    expect{
      click_link "削除"
    }.to  change( Tweet.all, :count ).by(-1)
  end
  scenario "自分以外が投稿したtweetをshowすれば削除ボタンが表示されない" do
    tweet = FactoryBot.create(:tweet)
    visit root_path
    click_link "hello"
    expect(page).not_to have_content '削除'
  end
  scenario "ヘッダーの自分の名前をクリックすると自分の投稿一覧が表示される" do
    tweet = FactoryBot.create(:tweet)
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_link "投稿"
    fill_in "tweet_text", with: "おはよう"
    click_button "投稿"
    click_link "投稿"
    fill_in "tweet_text", with: "さようなら"
    click_button "投稿"
    within 'header' do
      click_link user.nickname
    end
    expect(page).to have_content 'おはよう'
    expect(page).to have_content 'さようなら'
    expect(page).not_to have_content 'hello'
  end
  scenario "TOP画面の投稿者をクリックするとそのユーザーの一覧が表示される" do
    tweet = FactoryBot.create(:tweet)
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_link "投稿"
    fill_in "tweet_text", with: "おはよう"
    click_button "投稿"
    click_link "投稿"
    fill_in "tweet_text", with: "さようなら"
    click_button "投稿"
    click_link tweet.user.nickname
    expect(page).not_to have_content 'おはよう'
    expect(page).not_to have_content 'さようなら'
    expect(page).to have_content 'hello'
  end
  scenario "コメントすると表示される" do
    tweet = FactoryBot.create(:tweet)
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_link "hello"
    fill_in "comment_text", with: "ハロー"
    click_button "コメント"
    expect(page).to have_content 'ハロー'
  end
end
