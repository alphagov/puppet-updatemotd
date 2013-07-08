# updatemotd

Puppet module for managing `update-motd(5)` on Ubuntu systems.

## Example usage

Include with default parameters:
```
include updatemotd
```

Create an additional fragment:
``` puppet
updatemotd::fragment { 'important':
  content => '#!/bin/bash
/bin/echo "This machine is of utmost importance!"',
}
```

## License

See [LICENSE](LICENSE) file.
