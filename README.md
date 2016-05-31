Ansible
=======

Run Ansible from this Docker container instead of installing Ansible on your machine. It uses Ansible from source and you can optionally choose the branch and version to execute.

Usage
-----

* If you deploy to `localhost`, you playbook must not override the `localhost`

Run

```
docker run -it --rm \
  -v "/path/to/ansible-artifacts":/ansible \
  -v "$(echo $HOME)/.ssh/id_rsa":/root/.ssh/id_rsa \
  --env "LOCAL_USER=$(whoami)" \
  thomass/ansible bash
```

Now you can execute you mounted playbooks under `/ansible`.

Configuration
-------------

You can configure you container by environment variables.

|Variable | Description |
|----------|------|
| UPDATE_REPO | Merge the latest commits to the Ansible repository |
| BRANCH | The branch to use from the Ansible repository |
| VERSION | The commit or tag to use from the Ansible repository |
| USE_THOMASS_REPO | Instead of the official git repository use the one from https://github.com/ThomasSteinbach/ansible |

Licence
-------

The whole repository is licenced under BSD. Please mention following:

github.com/ThomasSteinbach (thomass at aikq.de)
