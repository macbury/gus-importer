# Gus::Importer

Simple gem for extracting data from gus XML

## Installation

Add this line to your application's Gemfile:

    gem 'gus-importer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gus-importer

## Usage

``` ruby
Gus::Importer::ProvinceParser.parse(file) do |name, uuid|
  puts "#{name} => #{uuid}"
end
```

``` ruby
Gus::Importer::StreetsParser.parse(file) do |street|
  puts "#{street.feature} #{street.second_name} #{street.name} => #{street.uuid}, #{street.city_uuid}"
end
```
## Contributing

1. Fork it ( http://github.com/<my-github-username>/gus-importer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
