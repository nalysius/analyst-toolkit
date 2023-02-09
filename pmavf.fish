#!/usr/bin/fish

# This script aims to find the version of a PHPMyAdmin installation.

if test (count $argv) -lt 1
    echo 'Usage: fish pmavf.fish <url>'
    exit 1
end

set pma_url $argv[1]

# Check /ChangeLog file
set changelog (curl -s "$pma_url/ChangeLog" 2>/dev/null)

echo "Checking the $pma_url/ChangeLog file..."
# Test it's the ChangeLog, not a 404 page
if test $changelog[1] = 'phpMyAdmin - ChangeLog'
    echo 'The ChangeLog file has been found.'
    echo ''
    # TODO: loop on each line and use a regex
    # If the format changes, it would break
    echo "Version: $changelog[4]"
    exit 0
else
    echo 'The ChangeLog has not been found.'
end

# Check /Documentation.html file
# <title>phpMyAdmin 3.5.8.2 - Documentation</title>

echo "Checking the $pma_url/Documentation.html file..."
set documentation_version (curl -s "$pma_url/Documentation.html" 2>/dev/null | grep -Po 'phpMyAdmin ([0-9.]+) - Documentation' | cut -d ' ' -f2)

if test -z $documentation_version
    echo "The Documentation.html file has not been found."
else
    echo 'The version has been identified from the Documentation.html file.'
    echo ''
    echo "Version: $documentation_version"
    exit 0
end


