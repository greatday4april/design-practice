def markdown_to_html(markdown)
  paragraphs = []
  paragraph = ''
  block_quote_open = false
  strikethrough_open = false
  line_idx = 0
  while line_idx < markdown.length
    idx = 0
    line = markdown[line_idx]
    while idx < line.length
      char = line[idx]
      if char != "\n"
        # if we see the block quote
        if line[idx..(idx + 1)] == '> '
          # we only add the tag if it's the first block quote
          paragraph += '<blockquote>' unless block_quote_open
          block_quote_open = true
          idx += 2
        elsif line[idx..(idx + 1)] == '~~'
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
        if line[idx + 1] != "\n" # single line break
          # only append </blockquote> if next line does not have blockquote
          if line_idx == markdown.length - 1 || (markdown[line_idx + 1][0..1] != '> ' && block_quote_open)
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
    line_idx += 1
  end

  # we also need to append the last paragraph
  unless paragraph.empty?
    paragraph += '</blockquote>' if block_quote_open
    paragraphs << paragraph
  end

  # in the end we should join the paragraphs into HTML
  paragraphs.map { |paragraph| "<p>#{paragraph}</p>" }.join("\n")
end

input = ["This is a paragraph with a soft\n",
         "line break.\n\n",
         "This is another paragraph that has\n",
         "> Some text that\n",
         "is in a\n",
         "> block quote.\n\n",
         'This is another paragraph with a ~~strikethrough~~ word.']

puts markdown_to_html(input)
puts
