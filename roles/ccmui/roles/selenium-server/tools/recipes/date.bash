#!/bin/bash -e

function main()
{
    local appPath="$(cd "$(dirname "${0}")" && pwd)"
    local command='date'

    "${appPath}/../../../../../../tools/run-remote-command.bash" \
        --attribute-file "${appPath}/../attributes/selenium.bash" \
        --command "${command}" \
        --machine-type 'master'
}

main "${@}"
