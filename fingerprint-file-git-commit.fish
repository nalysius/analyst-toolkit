#!/usr/bin/fish

# This script aims to help in fingerprinting.
# It loops over all Git commits on a given file, and
# compares the hash of <filePath> with <expectedSha256>
# Then it prints the commits in which the hash matches.

if test (count $argv) -lt 2
    echo 'Usage: fish fingerprint-file-git-commit.fish <filePath> <expectedSha256>'
    exit 1
end

set file_path $argv[1]
set expected_sha256 $argv[2]

# Loop over all the tags
for commit in (git log --oneline -- $file_path | cut -d ' ' -f1)
    git checkout $commit &> /dev/null
    # Check if the file exists in this commit
    if test -e $file_path
	set hash (shasum -a 256 $file_path | cut -d ' ' -f 1)
	# The hashes match
	if test $hash = $expected_sha256
	    echo "$commit"
	end
    end
end

