#!/usr/bin/fish

# This script aims to find the version of a TYPO3 CMS installation.

if test (count $argv) -lt 1
    echo 'Usage: fish typo3vf.fish <url>'
    exit 1
end

set typo3_url $argv[1]

# The path (on the remote server & in the git repository) of the file to use
# to check the hash
set file_path 'typo3/sysext/core/Resources/Public/JavaScript/SecurityUtility.js'

# The hash of the file on the remote server
set the_hash (curl -ks $typo3_url/$file_path | shasum -a 256 | cut -d ' ' -f 1)

# Execute fingerprint-file-git.fish to find the tags in which the file
# is exactly the same
set script_dir (realpath (dirname (status --current-filename)))
$script_dir/fingerprint-file-git.fish "$file_path" "$the_hash"

