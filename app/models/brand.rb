class Brand < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    {id: '', name: '---'},
    {id: 1, name: 'シャネル'}, {id: 2, name: 'ナイキ'},
    {id: 3, name: 'ルイ ヴィトン'}, {id: 4, name: 'シュプリーム'},
    {id: 5, name: 'アディダス'},
  ]
end