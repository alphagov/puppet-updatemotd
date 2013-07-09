# updatemotd

Puppet module for managing `update-motd(5)` on Ubuntu systems.

## Example usage

Include with default parameters:
```
include updatemotd
```

Define some static content for `motd.tail(5)`:
``` puppet
class { 'updatemotd':
  content => 'Welcome, humanoid!',
}
```

Manage more advanded scripted content:
``` puppet
class { 'updatemotd':
  purge_directory => true,
}
updatemotd::script { 'important':
  content => '#!/bin/bash\nexec uptime\n',
}
```

## License

See [LICENSE](LICENSE) file.
