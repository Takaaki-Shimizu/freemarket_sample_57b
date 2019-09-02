crumb :root do
  link "メルカリ"
end
# メルカリ＞マイページ
crumb :mypages do
  link 'マイページ'
  parent :root
end
# メルカリ＞マイページ＞本人情報の登録
crumb :personal_information do|personal_information|
  link '本人情報の登録'
  parent :mypages
end
# メルカリ＞マイページ＞ログアウト
crumb :logout do|logout|
  link 'ログアウト'
  parent :mypages
end
# メルカリ＞マイページ＞プロファイル
crumb :profile do|profile|
  link 'プロfフィール'
  parent :mypages
end

