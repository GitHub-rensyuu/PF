module Public::CustomersHelper
    def emphasize_keyword(nickname, keyword)
        # 検索キーワードに一致する本文を1行を抜き出す
        keyword = keyword.split(/[[:blank:]]+/)
        nickname_array = nickname.split(/\R/)
        first_match_line = nickname_array.find { |e| /#{keyword}/ =~ e }
    
        # 抜き出した本文を100文字に省略する
        trancate_line = if first_match_line.present?
                          truncate(first_match_line, length: 110).delete '#,`,*,\,'
                        else
                          truncate(nickname, length: 110).delete '#,`,*,\,'
                        end
        # 検索キーワードに一致する文字を太字にする
        highlight(trancate_line, keyword, :highlighter => '<span class="keyword-highlight">\1</span>')
    end
end
