#!/bin/bash
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)
echo $CURRENT_BRANCH
echo $LAST_COMMIT
