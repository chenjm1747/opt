json.array!(@azufangs) do |azufang|
  json.extract! azufang, :id, :username, :password, :innertext, :xiaoqu, :title, :area, :minprice, :lianxiren, :phone, :tupian
  json.url azufang_url(azufang, format: :json)
end
