# cmis-tools

Tools for the WAM CMIS project

## check-environment

Checks for the existence of a CollectiveAccess installation and the definition of the `$COLLECTIVEACCESS_HOME` environment variable.
Other scripts use it to perform a basic sanity check before proceeding.

    USAGE:
        check-environment

In scripts with `set -e`, simply running the `check-environment` script will cause the calling script to abort on failure.
However it is recommended to use a construct such as:

    check-environment || exit 1

Or:

    if [[ ! check-environment ]]; then
        echo 'Environment check failed, bailing out'
        exit 1
    fi

## init-wamcmis

Initialisation script for providence / CMIS.
This script is intended to be run _once_ per environment, and creates all the necessary directories and performs initial clones of git repositories.
Everything in this script is hardcoded, there are no arguments.

    USAGE:
        init-wamcmis

Note that this script does not do the manual configuration recommended in the subsection under `deploy-wamcmis`.

## deploy-wamcmis

Main deployment script for providence / CMIS.

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
    deploy-wamcmis [MODE] [OPTIONS]

MODE:
    The mode sets the defaults for all of the options:

    providence         Deploy the software code for providence
    cmis-local-conf    Deploy the local configuration
    all                Deploy both providence and local configuration

    The "all" mode, which is the default, is a synonym for running the
    "providence" mode followed if successful by the "cmis-local-conf" mode.

OPTIONS:
    Defaults shown here in (parentheses) are for the current mode (providence):

    -p PATH    Path to the local git repository (/data/github/providence)
    -r REMOTE  Remote repository to pull updates from (origin)
    -b BRANCH  Branch to check out before retrieving updates (develop)
    -d PATH    Path containing deployment directories (/data/cmis/collectiveaccess/providence)
    -m PATH    Path to the media directory (/data/cmis/collectiveaccess/media)
    -i PATH    Path to the import directory (/data/cmis/collectiveaccess/import)
    -t NAME    Name of the tag, this is used for the local subdir name and
               (optionally) to create a tag in the repo (20140627114741)
    -x PREFIX  Prefix to use before the tag name, this is used for tag name only
               (wamuseum_)
    -l NAME    Name of the symlink to create; this should match external
               configuration (current)
    -s SERVICE Name of service to restart (php5-fpm)
    -P         Don't pull latest changes from upstream repository (false)
    -D         Don't deploy changes into "live" directories (false)
    -M         Don't create a link to external media path, use new directory
               under deployment path (false)
    -I         Don't create a link to external import path, use new directory
               under deployment path (false)
    -T         Don't create and push a tag (false)
    -S         Don't restart any service (false)
    -h         Show this help text and quit

### Reversing a Deployment

The deployment script does not currently handle deployment reversals, these must be done manually.
(For example, you run a deployment and then realise there is a major problem, and need to wind back to the previous release).

1. To revert the running code version:
  1. `cd [target-parent-path]` to change directory to the target parent path (e.g. with defaults, this is `cd /data/cmis/collectiveaccess/providence`).
  2. `rm [symlink-name]` to remove the existing symbolic link (e.g. with defaults, this is `rm current`).
  3. `ln -s [version] [symlink-name]` with the relevant version to create a new symbolic link to the version you want to run, usually the previous version to the current one (e.g. with defaults and resetting to version 20140423154109, this is `ln -s 20140423154109 current`).
2. To restart the server:
  1. `sudo service php5-fpm restart` to restart FPM, this will ensure that the latest code is active and any previously cached PHP code is refreshed.
3. To remove the tag:
  1. `cd [clone-path]` to change directory to the path where the repo is cloned (e.g. with defaults, this is `cd /data/github/providence`).
  2. `git tag -d [tag-prefix][tag-name]` to remove the tag from the local repo (e.g. with defaults and removing a version 20140423154109, this is `git tag -d wamuseuem_20140423154109`).
  3. `git push origin :refs/tags/[tag-prefix][tag-name]` to push the removal of the tag to the remote repo (e.g. with defaults and removing a version 20140423154109, this is `git push origin :refs/tags/wamuseum_20140423154109`).

## export-mysql

Exports the database contents to a zipped SQL file in the current working directory, or specified directory.

    USAGE:
        export-mysql [EXPORT_PATH]

## export-profile

Exports an installation profile from a CollectiveAccess installation and then removes the superfluous taxonomy terms as these are loaded with the records via import scripts.
It is configured to replace the `wamcmis.xml` file stored at `install/profiles/xml/` in `$COLLECTIVEACCESS_HOME` by default, or in the specified directory.

    USAGE:
        export-profile [EXPORT_PATH]

## backup-mysql

Higher level script that uses `export-mysql` to do the work.
Called directly by a cron job to execute backups.
Rotates backups so that only a given number are kept (number defined by $backupsToKeep in the script).

## backup-profile

Higher level script that uses `export-profile` to do the work.
Called directly by a cron job to execute backups.
Rotates backups so that only a given number are kept (number defined by $backupsToKeep in the script).

## switchdb

Development tool which automates switching in of a relevant setup file, which allows use of different databases and configurations.

    USAGE:
        switchdb SETTINGS_FILE
