# StephanyCryptodemo

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/stephany_cryptodemo`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stephany_cryptodemo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stephany_cryptodemo

## Usage

**1] To run, please execute**
```
./bin/console 
```

**2] To create the blockchain:**
```
sdaneri_blockchain = StephanyCryptodemo::Blockchain.new
 => #<StephanyCryptodemo::Blockchain:0x007f99ba1661c8 @chain=[{:index=>1, :timestamp=>1524452221, :transactions=>[], :proof=>100, :previous_hash=>1}], @current_transactions=[]>
```

**3] To know which is the last Block**
```
last_block = sdaneri_blockchain.last_block
=> {:index=>1, :timestamp=>1524452221, :transactions=>[], :proof=>100, :previous_hash=>1}
```

**4] To get the proof of work of the last block**
```
last_proof_of_work = last_block[:proof]
=> 100
```

**5] To get the a new valid proof according to the intern algorithm:**
```
proof = sdaneri_blockchain.proof_of_work(last_proof_of_work)
=> 33575 
```

**6] To validate the proof of work is accomplishing the requirement**
```
value_to_validate = "#{last_proof_of_work}#{proof}"
 => "10033575" 
```

```
Digest::SHA256.hexdigest(value_to_validate)
=> "593057e494bb665192d458acd99765fb31c072a0ab65d977c26c01c4f7c90000" 
```

**7] As a reward for the mining effort of finding a valid proof of work, then we have to give the person a price of one crypto coin:**
```
sdaneri_blockchain.new_transaction('StephanyCryptodemo', 'Stephany', 1)
=> 0 
```

**8] We need to attach the most recent transaction to the blockchain**
```
block_2 = sdaneri_blockchain.new_block(proof)
 => {:index=>2, :timestamp=>1524454721, :transactions=>[{:sender=>"StephanyCryptodemo", :recipient=>"Stephany", :amount=>1}], :proof=>33575, :previous_hash=>"37ad9bd6fca3c047de47f27b540cd14c280a7fc015e06df20af15a3f48850f76"} 

```
Is also possible to add the last proof of work:
```
block_2 = sdaneri_blockchain.new_block(proof, sdaneri_blockchain.hash(last_block))
 => {:index=>2, :timestamp=>1524454721, :transactions=>[{:sender=>"StephanyCryptodemo", :recipient=>"Stephany", :amount=>1}], :proof=>33575, :previous_hash=>"37ad9bd6fca3c047de47f27b540cd14c280a7fc015e06df20af15a3f48850f76"} 

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sdanerib/stephany_cryptodemo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StephanyCryptodemo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/stephany_cryptodemo/blob/master/CODE_OF_CONDUCT.md).
