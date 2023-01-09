```mermaid
erDiagram

entities {
  re name "説明"
  r product "商品"
  e favorit_product "お気に入り商品"
  r shopping_account "買い物アカウント"
  r cart "カート"
  e undelivered_order "未配達の注文"
  e cancel_order "キャンセルした注文"
  e delivered_order "配達した注文"
  r order_product  "注文した商品"
  r order_status "注文ステータス"
}
```