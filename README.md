cmis-tools
==========

Tools for the WAM CMIS project

deploy-wamcmis
--------------

It is recommended to run this script under a user(s) with password-less sudo access for the `service` command.  To set this up, add the following to your `/etc/sudoers` file:

    %deployers	ALL = NOPASSWD: /usr/sbin/service

Then create the `deployers` group and add the relevant user(s) to it:

    sudo addgroup deployers
    sudo adduser [username] deployers

This will allow the user(s) to restart the web server automatically whenever a deployment is performed.

    USAGE:
        deploy-wamcmis [OPTIONS]
    
    OPTIONS:
        --clone-path=<path>         The path where the local git clone exists
        --target-parent-path=<path> The path containing deployment subdirectories
        --tag-name=<name>           The name of the tag, this is used for the local
                                    subdirectory name and (optionally) to create a
                                    tag in the git repository
        --symlink-name=<name>       The name of the symlink to create; this should
                                    match the server config
        --skip-pull                 Don't pull latest changes from upstream
        --skip-deploy               Don't copy changes from the git clone to the
                                    target directory
        --skip-link                 Don't create a new link in the target directory
        --skip-restart-server       Don't restart the web server
        --skip-push-tag             Don't create and push a tag in the repository
        -h, --help                  Show this help text and quit

switchdb
--------

This is a development tool which automates switching in of a relevant setup file, which allows use of different databases and configurations.

