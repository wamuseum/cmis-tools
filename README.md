= cmis-tools =

Tools for the WAM CMIS project

== deploy-wamcmis ==

=== Configuration ===

It is recommended to run this script under a user(s) with password-less sudo access for the `service` command.
To set this up, add the following to your `/etc/sudoers` file (you might need to add the writable flag to the file first):

    %deployers	ALL = NOPASSWD: /usr/sbin/service

Then create the `deployers` group and add the relevant user(s) to it:

    sudo addgroup deployers
    sudo adduser [username] deployers

This will allow the user(s) to restart the web server automatically whenever a deployment is performed.

=== Execution ===

    USAGE:
        deploy-wamcmis [OPTIONS]

    OPTIONS:
        -c=<path>, --clone-path=<path>         The path to the local git clone.
        -p=<path>, --target-parent-path=<path> The path containing deployment subdirectories.
        -t=<name>, --tag-name=<name>           The name of the tag, this is used for the local subdir
                                               name and (optionally) to create a tag in the repo.
        -s=<name>, --symlink-name=<name>       The name of the symlink to create; this should match
                                               the server configuration.
        -P, --skip-pull                        Don't pull latest changes from upstream repository.
        -D, --skip-deploy                      Don't copy changes from the git clone to the target.
        -L, --skip-link                        Don't create a new link in the target directory.
        -R, --skip-restart-server              Don't restart the web server.
        -T, --skip-push-tag                    Don't create and push a tag in the repository.
        -h, --help                             Show this help text and quit.

switchdb
--------

This is a development tool which automates switching in of a relevant setup file, which allows use of different databases and configurations.
