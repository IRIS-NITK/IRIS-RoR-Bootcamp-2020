json.array! @articles do |article|
  json.title article.title
  json.url article_path(article)
end
