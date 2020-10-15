# frozen_string_literal: true

require_relative '../lfu_cache'

describe 'LFU cache' do
  let(:actions_a) { %w[LFUCache get put get put put get get] }
  let(:params_a) { [[2], [2], [2, 6], [1], [1, 5], [1, 2], [1], [2]] }
  let(:actions_b) { %w[LFUCache put get] }
  let(:params_b) { [[0], [0, 0], [0]] }

  it 'output correct values' do
    actions_a.shift
    cache = LFUCache.new(*params_a.shift)
    output = []
    (0...actions_a.length).each do |idx|
      if actions_a[idx] == 'put'
        cache.put(*params_a[idx])
      else
        output << cache.get(*params_a[idx])
      end
    end
    expect(output).to eq([-1, -1, 2, 6])
  end

  it 'works with 0 capacity' do
    actions_b.shift
    cache = LFUCache.new(*params_b.shift)
    output = []
    (0...actions_b.length).each do |idx|
      if actions_b[idx] == 'put'
        cache.put(*params_b[idx])
      else
        output << cache.get(*params_b[idx])
      end
    end
    expect(output).to eq([-1])
  end
end
