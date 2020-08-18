# ルート
crumb :root do
  link "トップページ", root_path
end

# 1.マイページ内-------------------------------------
# マイページ
crumb :users do
  link "マイページ", user_path(current_user.id)
  parent :root
end

# 自己紹介
crumb :profiles do
  link "自己紹介", edit_user_profile_path
  parent :users
end

# いいねした商品一覧
crumb :likes do
  link "いいねした商品一覧", likes_users_path
  parent :users
end

# 出品商品詳細
crumb :show do
  link "商品詳細", item_path
  parent :users
end

# クレカ登録
crumb :card do
  link "クレジットカード情報入力", new_card_path
  parent :users
end

# クレカ情報・削除
crumb :card do
  link "クレジットカード情報入力", card_path(current_user.id)
  parent :users
end

# クレカ削除完了
crumb :delete do
  link "クレカ削除完了", delete_card_index_path
  parent :users
end

# 2.出品ページ内---------------------------------
# 出品ページ
crumb :new do
  link "出品", new_item_path
  parent :root
end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).