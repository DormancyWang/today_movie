require 'http'
require 'nokogiri'

HEADER = {
  'cookie' => 'zsxq_access_token=CAF78CFA-A1EB-923C-E81D-6DD208C9848E_272FB7DC97834161; abtest_env=product; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22422211485888148%22%2C%22first_id%22%3A%2218696ca68dfe6b-030e9bc6f87c2c2-1f525634-3686400-18696ca68e06d5%22%2C%22props%22%3A%7B%22%24latest_traffic_source_type%22%3A%22%E8%87%AA%E7%84%B6%E6%90%9C%E7%B4%A2%E6%B5%81%E9%87%8F%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC%22%2C%22%24latest_referrer%22%3A%22https%3A%2F%2Fwww.google.com.hk%2F%22%7D%2C%22identities%22%3A%22eyIkaWRlbnRpdHlfY29va2llX2lkIjoiMTg2OTZjYTY4ZGZlNmItMDMwZTliYzZmODdjMmMyLTFmNTI1NjM0LTM2ODY0MDAtMTg2OTZjYTY4ZTA2ZDUiLCIkaWRlbnRpdHlfbG9naW5faWQiOiI0MjIyMTE0ODU4ODgxNDgifQ%3D%3D%22%2C%22history_login_id%22%3A%7B%22name%22%3A%22%24identity_login_id%22%2C%22value%22%3A%22422211485888148%22%7D%2C%22%24device_id%22%3A%2218696ca68dfe6b-030e9bc6f87c2c2-1f525634-3686400-18696ca68e06d5%22%7D; UM_distinctid=1875742b2b1f64-0e84f90e2bb319-1e525634-1fa400-1875742b2b214ff',
  'accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
  'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
}.freeze

res = HTTP.headers(**HEADER).get('https://articles.zsxq.com/id_th0rdvb3xz1e.html')
doc = Nokogiri.HTML5(res.to_str)
array = doc.css('li[data-list=bullet] a')
hrefs = []
array.each do |a|
  hrefs << a['href']
end

hrefs

array = [[" ", 3], ["a", 1], ["e", 5], ["g", 1], ["h", 1], ["i", 1], ["m", 2], ["o", 1], ["r", 1], ["s", 4], ["t", 1]]
array = [["b", 2], ["a", 1], ["g", 1], ["h", 1], ["i", 1]]
str = []
length = array.sum do |a|
  a[1]
end
visited = Array.new(array.length, 0)
ans = []
def dfs(str, array, visited, length, ans)
  if str.length == length
    ans << str.join
    return
  end

  visited.each_with_index do |val, index|
    if val < array[index][1]
      str << array[index][0]
      visited[index] += 1
      dfs(str, array, visited, length, ans)
      str.pop
      visited[index] -= 1
    end
  end
end
