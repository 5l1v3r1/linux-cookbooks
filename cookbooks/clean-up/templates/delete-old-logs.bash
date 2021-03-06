#!/bin/bash -e

function main()
{
    local logFolderPaths=("${@}")

    # Default Log Folder Path

    if [[ "${#logFolderPaths[@]}" -lt '1' ]]
    then
        logFolderPaths+=('/var/log')
    fi

    # Walk Each Log Folder Path

    local i=0

    for ((i = 0; i < ${#logFolderPaths[@]}; i = i + 1))
    do
        if [[ "${logFolderPaths[i]}" = '' || ! -d "${logFolderPaths[i]}" ]]
        then
            echo -e "\033[1;31mERROR: folder '${logFolderPaths[i]}' not found\033[0m" 1>&2
        else
            find \
                -L \
                "${logFolderPaths[i]}" \
                -type f \
                \( \
                    -regex '.*-[0-9]+' -o \
                    -regex '.*\.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\.log' -o \
                    -regex '.*\.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\.txt' -o \
                    -regex '.*\.[0-9]+' -o \
                    -regex '.*\.[0-9]+\.log' -o \
                    -regex '.*\.gz' -o \
                    -regex '.*\.log\.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]T[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' -o \
                    -regex '.*\.old' -o \
                    -regex '.*\.xz' \
                \) \
                -delete \
                -print
        fi
    done
}

main __LOG_FOLDER_PATHS__