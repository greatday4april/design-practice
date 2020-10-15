# markdown processor， 给你的是string，里面有\n, \n\n, ~~, >， output是替换成带tag, <p></p> <blockquote>的string


=begin
Markdown processor
String input = "This is a paragraph with a soft\n" + 
    "line break.\n\n" +
    "This is another paragraph that has\n" +
    "> Some text that\n" +
    "> is in a\n" +
    "> block quote.\n\n" +
    "This is another paragraph with a ~~strikethrough~~ word.";

    Expected Output:
"<p>This is a paragraph with a soft<br />line break.</p>

<p>This is another paragraph that has <br />
  <blockquote>Some text that<br />is in a<br />block quote</blockquote>
</p>

<p>This is another paragraph with a <del>strikethrough</del> word.</p>"


注意*  每行 ">"后面的内容要去掉leading spaces

Note:
It's not important to produce this specific output! We only care if the HTML is valid.

Iterate每个字去判断他给的需求, 非常冗赘...
最后在跟讨论优化, 聊到可用stack去纪录special character
=end


# handle each paragraph, put them in <p></p> and join them with space
# 1. double \n closes a p tag and open a new one
# 2. single \n adds a <br /> tag
# 3. ~~ open <del> or closes </del>
# 4. for >, we open <blockquote> if we havent opened, we close <blockquote> if this is the last line with ">"

def markdown_to_html(markdown)
    paragraphs = []
    paragraph = ''
    separators = []
    idx = 0
    while idx < markdown.length
      char = markdown[idx]
      last_char = special_chars_stack.last
      if last_char == "\n"
        special_chars_stack.pop
        if markdown
      else


      end
    end


      if char == "\n"
        if markdown[idx+1] != "\n" # line break instead of paragraph switch
          # only append </blockquote> if new line does not have blockquote
          if markdown[idx+1..(idx+2)] != '> ' && block_quote_open
            paragraph += '</blockquote>'
            block_quote_open = false
          end
          paragraph += '<br />'
          idx += 1
        else
          if block_quote_open
            paragraph += '</blockquote>'
            block_quote_open = false
          end
          paragraphs << paragraph
          paragraph = ''
          idx += 2
        end
      else
        if markdown[idx..(idx+1)] == '> '
          paragraph += '<blockquote>' if !block_quote_open
          block_quote_open = true
          idx += 2
        elsif markdown[idx..(idx+1)] == '~~'
          if strikethrough_open
            paragraph += '</del>'
            strikethrough_open = false
          else
            paragraph += '<del>'
            strikethrough_open = true
          end
          idx += 2
        else
          paragraph += char
          idx += 1
        end
      end
    end
  
    # append the last paragraph
    paragraph += '</blockquote>' if block_quote_open
    paragraphs << paragraph
  
    paragraphs.map {|paragraph| "<p>#{paragraph}</p>"}.join(' ')
  end
  
  input = "This is a paragraph with a soft\n" +
      "line break.\n\n" +
      "This is another paragraph that has\n" +
      "> Some text that\n" +
      "> is in a\n" +
      "> block quote.\n\n" +
      "This is another paragraph with a ~~strikethrough~~ word."
  
  p markdown_to_html(input)
  