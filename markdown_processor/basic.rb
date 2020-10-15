# frozen_string_literal: true

# Markdown processor
# String input = "This is a paragraph with a soft\n" +
#     "line break.\n\n" +
#     "This is another paragraph that has\n" +
#     "> Some text that\n" +
#     "> is in a\n" +
#     "> block quote.\n\n" +
#     "This is another paragraph with a ~~strikethrough~~ word.";
#
#     Expected Output:
# "<p>This is a paragraph with a soft<br />line break.</p>
#
# <p>This is another paragraph that has <br />
#   <blockquote>Some text that<br />is in a<br />block quote.</blockquote>
# </p>
#
# <p>This is another paragraph with a <del>strikethrough</del> word.</p>"
#
#
# 注意*  每行 ">"后面的内容要去掉leading spaces
#
# Note:
# It's not important to produce this specific output! We only care if the HTML is valid.
#
# Iterate每个字去判断他给的需求, 非常冗赘...
# 最后在跟讨论优化, 聊到可用stack去纪录special character

# 写下注释
# we can handle paragraph by paragraph, put them in an array, we can join them together in the end
# 1. double \n closes a p tag and open a new one
# 2. single \n adds a <br /> tag
# 3. ~~ open <del> or closes </del>
# 4. for >, we open <blockquote> if we havent opened, we close <blockquote> if this is the last line with ">"

def markdown_to_html(markdown)
  # 如果markdown是array of strings，那么先：markdown = markdown.join
  paragraphs = []
  paragraph = ''
  block_quote_open = false
  strikethrough_open = false
  idx = 0
  while idx < markdown.length
    char = markdown[idx]
    if char != "\n"
      # if we see the block quote
      if markdown[idx..(idx + 1)] == '> '
        # we only add the tag if it's the first block quote
        paragraph += '<blockquote>' unless block_quote_open
        block_quote_open = true
        idx += 2
      elsif markdown[idx..(idx + 1)] == '~~'
        # if we see the strikethrough, we need to check
        # if we are opening or closing
        if strikethrough_open
          paragraph += '</del>'
          strikethrough_open = false
        else
          paragraph += '<del>'
          strikethrough_open = true
        end
        idx += 2
      else
        # for all normal characters we just add to the paragraph
        paragraph += char
        idx += 1
      end
    else
      if markdown[idx + 1] != "\n" # single line break
        # only append </blockquote> if next line does not have blockquote
        if markdown[idx + 1..(idx + 2)] != '> ' && block_quote_open
          paragraph += '</blockquote>'
          block_quote_open = false
        end
        # we are not switching paragraph here
        paragraph += '<br />'
        idx += 1
      else
        # if the last line of the paragraph have block quote
        if block_quote_open
          paragraph += '</blockquote>'
          block_quote_open = false
        end
        # we are switching paragraph
        paragraphs << paragraph
        paragraph = ''
        idx += 2
      end
    end
  end

  # we also need to append the last paragraph
  unless paragraph.empty?
    paragraph += '</blockquote>' if block_quote_open
    paragraphs << paragraph
  end

  # in the end we should join the paragraphs into HTML
  paragraphs.map { |paragraph| "<p>#{paragraph}</p>" }.join("\n")
end

# test 注意他很可能会给你test case

input = "This is a paragraph with a soft\n" \
        "line break.\n\n" \
        "This is another paragraph that has\n" \
        "> Some text that\n" \
        "> is in a\n" \
        "> block quote.\n\n" \
        'This is another paragraph with a ~~strikethrough~~ word.'

puts markdown_to_html(input)
puts

input = "This is a sample \n" \
"~~input~~.\n\n" \
"> This is \n" \
"> a \n" \
"> blockquote.\n\n" \
"Another paragraph.\n\n"
puts markdown_to_html(input)
