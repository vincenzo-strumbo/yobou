# 予防 Yobou
A simple mysql/mysqldump wrapper

## Installation

```bash
$ gem install yobou
```

## How to use

```ruby
require 'yobou'

# Dump a DB into a SQL file
Yobou.dump(host: '127.0.0.1', username: 'user', password: 'password', database: 'my-database', filename: 'path/to/file.sql')
# => #<Yobou::Response:000 @errors=[], @success=true>

# Load a SQL file into a DB (dropping an existing database)
Yobou.load(host: '127.0.0.1', username: 'user', password: 'password', database: 'my-database', filename: 'path/to/file.sql')
# => #<Yobou::Response:000 @errors=[], @success=true>

# Load a SQL file into a DB (without dropping an existing database)
Yobou.load(host: '127.0.0.1', username: 'user', password: 'password', database: 'my-database', filename: 'path/to/file.sql', drop_existing: false)
# => #<Yobou::Response:000 @errors=[], @success=true>

```