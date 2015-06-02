#!/bin/bash
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
[if $CURRENT_BRANCH == 'stable']; do
