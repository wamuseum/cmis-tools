# cmis-tools

Tools for the WAM CMIS project

## deploy-wamcmis

### Configuration

It is recommended to run this script under a user(s) with password-less sudo access for the `service` command.
To set this up, add the following to your `/etc/sudoers` file (you might need to add the writable flag to the file first):

    %deployers	ALL = NOPASSWD: /usr/sbin/service

Then create the `deployers` group and add the relevant user(s) to it:

    sudo addgroup deployers
    sudo adduser [username] deployers

This will allow the user(s) to restart the web server automatically whenever a deployment is performed.
You may need to log out and back in if you want to add the `deployers` group to your current login session.

It is also recommended to use SSH to clone the project.  From the parent directory of where you want the clone to live:

    git clone git@github.com:wamuseum/providence.git

Note you will need to have the correct SSH keys set up in order for this to work.  See https://help.github.com/articles/generating-ssh-keys

### Execution

The script will normally perform the following five steps, each of which may be switched off using command-line arguments:

1. Pull latest changes from the upstream repository (`wamuseum/providence:master`).
   This ensures that any code changes are being deployed.
2. Merge the latest changes from the local clone of repository into a new copy of the server directory.
   This allows multiple versions to exist on the server side-by-side.
3. Create a symbolic link to the new server directory.
   This symlink should represent the path used in the server configuration, i.e. it is the "live" server path.
4. Restart the running php5-fpm process.
   Without this, php5-fpm would still be running the old (cached) version of the code.
5. Create a tag in the repository, and push it up to the remote repository (github).
   This records deployments in version control, so that diffs can be easily discovered.

### Command Line Usage

    USAGE:
        deploy-wamcmis [OPTIONS]

    OPTIONS:
        -c=<path>, --clone-path=<path>         The path to the local git clone.
        -p=<path>, --target-parent-path=<path> The path containing deployment subdirectories.
        -t=<name>, --tag-name=<name>           The name of the tag, this is used for the local subdir
                                               name and (optionally) to create a tag in the repo.
        -x=<prefix>, --symlink-prefix=<prefix> The prefix to use before the tag name, this is used for
                                               the tag in the repo only (not the local subdir name).
        -s=<name>, --symlink-name=<name>       The name of the symlink to create; this should match
                                               the server configuration.
        -P, --skip-pull                        Don't pull latest changes from upstream repository.
        -D, --skip-deploy                      Don't copy changes from the git clone to the target.
        -L, --skip-link                        Don't create a new link in the target directory.
        -R, --skip-restart-server              Don't restart the web server.
        -T, --skip-push-tag                    Don't create and push a tag in the repository.
        -h, --help                             Show this help text and quit.

Notes:

* Switches cannot be combined in standard *nix fashion, so `deploy-wamcmis -R -T` is valid, `deploy-wamcmis -RT` will not work.
* An equal sign is always required for arguments with values, even for the short forms, so `deploy-wamcmis -c=/some/path` is valid, `deploy-wamcmis -c /some/path` is not.

### Reversing a Deployment

The deployment script does not currently handle deployment reversals, these must be done manually.
(For example, you run a deployment and then realise there is a major problem, and need to wind back to the previous release).

1. To revert the running code version:
  1. `cd [target-parent-path]` to change directory to the target parent path (e.g. with defaults, this is `cd /data/cmis/collectiveaccess/providence`).
  2. `rm [symlink-name]` to remove the existing symbolic link (e.g. with defaults, this is `rm current`).
  3. `ln -s [version] [symlink-name]` with the relevant version to create a new symbolic link to the version you want to run, usually the previous version to the current one (e.g. with defaults and resetting to version 20140423154109, this is `ln -s 20140423154109 current`).
2. To restart the server:
  1. `sudo service apache2 restart` to restart Apache, this will ensure that the latest code is active and any previously cached PHP code is refreshed.
3. To remove the tag:
  1. `cd [clone-path]` to change directory to the path where the repo is cloned (e.g. with defaults, this is `cd /data/github/providence`).
  2. `git tag -d [tag-prefix][tag-name]` to remove the tag from the local repo (e.g. with defaults and removing a version 20140423154109, this is `git tag -d wamuseuem_20140423154109`).
  3. `git push origin :refs/tags/[tag-prefix][tag-name]` to push the removal of the tag to the remote repo (e.g. with defaults and removing a version 20140423154109, this is `git push origin :refs/tags/wamuseum_20140423154109`).

## switchdb

This is a development tool which automates switching in of a relevant setup file, which allows use of different databases and configurations.
