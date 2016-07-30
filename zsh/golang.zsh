echo "Loading $0"

# Similar to `npm link`, allow `go install` to use the non-vendor ("global") version of the
# dependency, ex. to test a work in progress.
#
# Usage: govenlink vendor/a/b/c
#
function govenlink {
    # A relative file path is expected as the first argument, rather than a golang import path,
    # to allow use of shell completion for building it.
    VENDOR_PATH=$1

    if [[ "$VENDOR_PATH" =~ "govenlink" ]]; then
        echo "ERR: $VENDOR_PATH looks like a backup path."
        return 1
    fi

    # Handle "vendor/a/b/c" and "./vendor/a/b/c".
    IMPORT_PATH=$(echo "$VENDOR_PATH" | sed 's/^[^v]*vendor\///g')

    if [ "$IMPORT_PATH" = "" ]; then
        echo "target must be a relative path, ex. vendor/a/b/c"
        return 1
    fi

    VENDOR_PATH="vendor/$IMPORT_PATH" # Now that it is normalized.
    BACKUP_PATH="${VENDOR_PATH}.govenlink"
    GLOBAL_PATH="$GOPATH/src/$IMPORT_PATH"

    if [ ! -d "$GLOBAL_PATH" ]; then
        echo "ERR: $GLOBAL_PATH link destination not found."
        return 1
    fi

    if [ -L "$VENDOR_PATH" ]; then
        echo "ERR: $VENDOR_PATH is a symlink. Already govenlink'ed?"
        return 1
    fi

    if [ -d "$VENDOR_PATH" ]; then
        echo "INFO: Currently vendored."

        if [ -d "$BACKUP_PATH" ]; then
            echo "ERR: Backup $BACKUP_PATH found. Already govenlink'ed?"
            return 1
        fi

        mv $VENDOR_PATH $BACKUP_PATH
        if [ $? -ne 0 ]; then
            echo "ERR: Failed to create $BACKUP_PATH backup."
            return 1
        fi
        echo " Backup $BACKUP_PATH created."
    fi

    ln -s $GLOBAL_PATH $VENDOR_PATH
    if [ $? -ne 0 ]; then
        echo "ERR: Failed to create link."
        return 1
    fi
}

