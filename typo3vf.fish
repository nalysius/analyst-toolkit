#!/usr/bin/fish

# This script aims to find the version of a TYPO3 CMS installation.

if test (count $argv) -lt 1
    echo 'Usage: fish typo3vf.fish <url>'
    exit 1
end

set typo3_url $argv[1]

# A list of paths where the version is printed
set file_paths 'typo3/sysext/install/composer.json' 'typo3/sysext/linkvalidator/composer.json' 'typo3/sysext/filelist/composer.json' 'typo3/sysext/t3editor/composer.json' 'typo3/sysext/extensionmanager/composer.json' 'typo3/sysext/opendocs/composer.json'

# Test for all composer.json in case some of them are missing
for file_path in $file_paths
    echo 'Testing path /'$file_path
    # "typo3/cms-core": "x.y.z"
    set typo3_version (curl -sk $typo3_url/$file_path | grep -Po '(?<="typo3/cms-core": ")[0-9.]+(?=")')

    if test -n $typo3_version
	echo 'Version found:' $typo3_version
	exit
    end
end

echo 'Version not found. You could try to find it by fingerprinting a file against the Git repository.

