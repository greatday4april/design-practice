# frozen_string_literal: true

# 1. 给输入为string，例如"2+3-999"，之包含+-操作，返回计算结果

class Calculator
  attr_accessor :expression
  def initialize(expression)
    @idx = 0
    @expression = expression
  end

  def eval
    res = 0
    number = 0
    start_idx = 0
    (0...expression.length).each do |end_idx|
      char = expression[end_idx]
      if char == '+' || char == '-'
        res += (expression[start_idx] != '-' ? 1 : -1) * number
        start_idx = end_idx
        number = 0
      else
        number = number * 10 + char.to_i
      end
    end
    res += (expression[start_idx] != '-' ? 1 : -1) * number
    res
  end

  def eval_with_parenthesis
    res = 0
    number = 0
    start_idx = 0
    while @idx < expression.length
      char = expression[@idx]
      if char == ' '
        @idx += 1
      elsif char == '('
        @idx += 1
        number = eval_with_parenthesis
      elsif char == '+' || char == '-' || char == ')'
        res += (expression[start_idx] != '-' ? 1 : -1) * number
        start_idx = @idx
        number = 0
        @idx += 1
        return res if char == ')'
      else
        number = number * 10 + char.to_i
        @idx += 1
      end
    end
    res += (expression[start_idx] != '-' ? 1 : -1) * number
    res
  end
end

p Calculator.new('2+3-999').eval # -994

# 2. 加上parenthesis， 例如"2+((8+2)+(3-999))"，返回计算结果

p Calculator.new('2+((8+2)+(3-999))').eval_with_parenthesis # -984

p Calculator.new('2-(8+2-(3-999))').eval_with_parenthesis # -1004

# TODO
# 3. follow up： 不光有数字和operator，还有一些变量，这些变量有些可以表示为一个数值，需要从给定的map里去get这个变量的value。然后有的变量不能转为数字，所以结果要包含这些不可变成数字的单词以及其他数字部分通过计算器得到的结果。

# 第三道题是加了变量名的。。会给你一个map比如{'a':1, 'b':2, 'c':3}，假设输入为"a+b+c+1"输出要是7，如果有未定义的变量，比如"a+b+c+1+d"输出就是7+d
