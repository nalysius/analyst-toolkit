#!/usr/bin/fish

# This script aims to help in fingerprinting.
# It loops over all Git tags of the current directory, and
# compares the hash of <filePath> with <expectedSha256>
# Then it prints the tags in which the hash matches.

if test (count $argv) -lt 2
    echo 'Usage: fish fingerprint-file-git.fish <filePath> <expectedSha256>'
    exit 1
end

set file_path $argv[1]
set expected_sha256 $argv[2]

# Loop over all the tags
for tag in (git tag)
    git checkout $tag &> /dev/null
    # Check if the file exists in this tag
    if test -e $file_path
	set hash (shasum -a 256 $file_path | cut -d ' ' -f 1)
	# The hashes match
	if test $hash = $expected_sha256
	    echo "$tag"
	end
    end
end

