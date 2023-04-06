class MovieController < ApplicationController
  MOVIE = Struct.new(:title, :cover_url, :region, :release, :rating, :detail_url)
  def index
    hash = {
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
    }
    res = HTTP.headers(**hash).get('https://movie.douban.com/')
    doc = Nokogiri.HTML5(res.to_s)
    lis = doc.css('#screening > .screening-bd > ul > li')
    @movies = []
    lis.each do |li|
      elem = li.css(".poster a img").first
      if elem.nil?
        next
      else
        detail_url = li.css(".poster a").first["href"]
        cover_url = elem["src"]
        @movies << MOVIE.new(li["data-title"], cover_url, li["data-region"], li["data-release"], li["data-rate"], detail_url)
      end
    end
    @movies.sort_by! do |m|
      m.rating.to_f
    end.reverse!
  end
end
