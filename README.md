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
Gus::Importer::HashParser.parse(file) do |name, uuid|
  => {:WOJ=>"30", :POW=>"27", :GMI=>"01", :RODZ_GMI=>"1", :SYM=>"0949336", :SYM_UL=>"20291", :CECHA=>"ul.", :NAZWA_1=>"Słowackiego", :NAZWA_2=>"Juliusza ", :STAN_NA=>"2014-02-14"}
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/gus-importer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
