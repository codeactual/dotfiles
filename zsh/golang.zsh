echo "Loading $0"

# Similar to `npm link`, allow `go install` to use the non-vendor ("global") version of the
# dependency, ex. to test a work in progress.
#
# Usage: govenlink vendor/a/b/c
#
function govenlink {
    _govenlink_init "$@"
    if [ $? -ne 0 ]; then
        return $?
    fi

    if [ ! -d "$GLOBAL_PATH" ]; then
        echo "ERR: $GLOBAL_PATH link destination not found. ==> go get $IMPORT_PATH"
        return 1
    fi

    if [ -L "$VENDOR_PATH" ]; then
        echo "ERR: $VENDOR_PATH is a symlink. Already govenlink'ed?"
        return 1
    fi

    if [ -d "$VENDOR_PATH" ]; then
        echo "INFO: Previously vendored."

        if [ -d "$BACKUP_PATH" ]; then
            echo "ERR: Backup $BACKUP_PATH found. Already govenlink'ed?"
            return 1
        fi

        mv $VENDOR_PATH $BACKUP_PATH
        if [ $? -ne 0 ]; then
            echo "ERR: Failed to create $BACKUP_PATH backup."
            return 1
        fi
        echo "Backup $BACKUP_PATH created."
    else
        VENDOR_PARENT_PATH=`dirname $VENDOR_PATH`
        if [ ! -d "$VENDOR_PARENT_PATH" ]; then
            echo "INFO: Not previously vendored. Created empty $VENDOR_PARENT_PATH to host symlink."
            mkdir -p $VENDOR_PARENT_PATH
            if [ $? -ne 0 ]; then
                echo "ERR: Failed to create $VENDOR_PARENT_PATH."
                return 1
            fi
        fi
    fi

    ln -s $GLOBAL_PATH $VENDOR_PATH
    if [ $? -ne 0 ]; then
        echo "ERR: Failed to create link."
        return 1
    fi
}

# Usage: govenunlink vendor/a/b/c
#
function govenunlink {
    _govenlink_init "$@"
    if [ $? -ne 0 ]; then
        return $?
    fi

    if [ ! -L "$VENDOR_PATH" ]; then
        echo "ERR: $VENDOR_PATH not a symlink. Not govenlink'ed yet?"
        return 1
    fi

    if [ ! -d "$BACKUP_PATH" ]; then
        echo "ERR: Backup $BACKUP_PATH not found. Please remove $VENDOR_PATH link manually."
        return 1
    fi

    rm --force $VENDOR_PATH
    if [ $? -ne 0 ]; then
        echo "ERR: Failed to create $BACKUP_PATH backup."
        return 1
    fi
    echo "$VENDOR_PATH symlink removed."

    mv $BACKUP_PATH $VENDOR_PATH
    if [ $? -ne 0 ]; then
        echo "ERR: Failed to restore $BACKUP_PATH backup."
        return 1
    fi
    echo "Backup $BACKUP_PATH restored."
}

# Share init for govenlink and govenunlink.
function _govenlink_init {
    if [ "$GOPATH" = "" ]; then
        echo "ERR: GOPATH not defined."
        return 1
    fi

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
}

