# NOTES

## read and write files; use command line arguments
ruby read file
https://www.rubyguides.com/2015/05/working-with-files-ruby/
```ruby
open(ARGV[1] || 'output.txt', 'a') do |output_file|
  File.readlines(ARGV[0] || 'input.txt').each do |feed|
  end
  output_file << ''
end
```

## handle CSV and directory
ruby all files in directory
https://alvinalexander.com/blog/post/ruby/ruby-how-process-each-file-directory-name-pattern/
https://github.com/greatday4april/the-investors-game/blob/df78e21634164c2d59f21440e47aa7cb803840b0/db/seeds.rb

```ruby
Dir.glob(File.dirname(__FILE__) + '/ticks/selected/*.csv') do |csv_filename|
  p "Reading & seeding Tick:#{csv_filename}"
  ticks = CSV.read(
    File.expand_path(csv_filename, File.dirname(__FILE__) + '/ticks/selected')
  )
  symbol = csv_filename.split('/')[-1].split('_')[0]
  ticks.map! do |tick|
    { symbol: symbol,
      tick_time: Time.zone.parse(tick[0]),
      open: tick[1].to_f,
      high: tick[2].to_f,
      low: tick[3].to_f,
      close: tick[4].to_f,
      volume: tick[5].to_i }
  end
  Tick.insert_all(ticks)
end
```

## ruby http call
`require 'httparty'`

https://www.rubyguides.com/2018/08/ruby-http-request/
https://github.com/jnunemaker/httparty/tree/master/examples

```ruby
response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
```

## ruby json

```
require 'json'
p JSON.generate({1:3, 2:4})
p JSON.parse('{1:3, 2:4}')
```

## ruby require
https://medium.com/@ellishim/understanding-require-vs-require-relative-vs-require-all-80e3b26d89e6
