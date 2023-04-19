# Analyst toolkit

This repository contains a set of scripts used to identify the version of
softwares.

## PHPMyAdmin Version Finder

PMAVF is a script used to identify the version of a PHPMyAdmin running online.
It searches for files containing the version to give the exact version.

In the future it could be smarter and check for existing or missing files
to guess a possible version.
TODO: use Fingerprint-file-git to fingerprint a file if we're in a Git
repository

## Fingerprint File Git

Fingerprint-file-git is a generic script used to fingerprint a software.
It takes a path to a file, the expected sha256 hash, and it loops over all
of the Git tags to find which tag matches.

## Fingerprint File Git Commit

Fingerprint-file-git-commit is a generic script used to fingerprint a software.
It takes a path to a file, the expected sha256 hash, and it loops over all
of the Git commit to find which commits matches.
