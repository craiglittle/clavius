# Clavius

[![Gem Version](https://badge.fury.io/rb/clavius.svg)](http://badge.fury.io/rb/clavius)
[![Build
Status](https://github.com/craiglittle/clavius/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/craiglittle/clavius/actions?query=branch%3Amaster)
[![Code Climate](https://codeclimate.com/github/craiglittle/clavius/badges/gpa.svg)](https://codeclimate.com/github/craiglittle/clavius)
[![Test Coverage](https://codeclimate.com/github/craiglittle/clavius/badges/coverage.svg)](https://codeclimate.com/github/craiglittle/clavius)

Date calculations based on a schedule.


## Installation

```
gem install clavius
```

## Configuration

```ruby
Clavius.configure do |c|
  c.weekdays = %i[mon tue wed thu fri]
  c.included = [Date.new(2023, 7, 1)]
  c.excluded = [Date.new(2023, 7, 4), Date.new(2023, 12, 25)]
end
```

## Usage

```ruby
Clavius.active?(Date.new(2023, 1, 5))

Clavius.days(5).before(Date.new(2023, 1, 5))

Clavius.days(2).after(Date.new(2023, 1, 5))

Clavius.between(Date.new(2023, 1, 1), Date.new(2023, 1, 8))
```

## Contributing

Pull requests are welcome, but consider asking for a feature or bug fix first
through the issue tracker. When contributing code, please squash sloppy commits
aggressively and follow [Tim Pope's guidelines](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
for commit messages.

## Copyright

Copyright (c) 2015-2023 Craig Little. See [LICENSE][license] for details.

[license]: https://github.com/craiglittle/clavius/blob/master/LICENSE
