# Clavius

Date calculations based on a schedule.

## Installation

```
gem install clavius
```

## Configuration

```ruby
Clavius.configure do |c|
  c.weekdays = %i[mon tue wed thu fri]
  c.included = [Date.new(2015, 6, 1)]
  c.excluded = [Date.new(2015, 1, 1), Date.new(2015, 12, 25)]
end
```

## Usage

```ruby
Clavius.active?(Date.new(2014, 1, 5))

Clavius.days(5).before(Date.new(2015, 1, 5))

Clavius.days(2).after(Date.new(2015, 1, 5))

Clavius.between(Date.new(2006, 1, 1), Date.new(2006, 1, 8))
```

## Contributing

Pull requests are welcome, but consider asking for a feature or bug fix first
through the issue tracker. When contributing code, please squash sloppy commits
aggressively and follow [Tim Pope's guidelines](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
for commit messages.

## Copyright

Copyright (c) 2015 Craig Little. See [LICENSE][license] for details.

[license]: https://github.com/craiglittle/clavius/blob/master/LICENSE
