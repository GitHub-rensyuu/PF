module ApplicationHelper
    # url文字ハイパーリンク化
    require "uri"

    def text_url_to_link text
    
      URI.extract(text, ['http','https'] ).uniq.each do |url|
        sub_text = ""
        sub_text << "<a style=\"white-space: nowrap;
                      overflow: hidden;
                      text-overflow: ellipsis;
                      display: block;\" href=" << url << " target=\"_blank\">" << url << "</a>"
    
        text.gsub!(url, sub_text)
      end
    
      return text
    end
    def recommended_rank_short(fullname)
      fullname[0]
    end
      
      
end
