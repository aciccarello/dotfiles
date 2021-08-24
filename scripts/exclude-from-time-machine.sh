#!/usr/bin/env bash
# See https://gist.github.com/peterdemartini/4c918635208943e7a042ff5ffa789fc1
(cd ~/Documents && find $(pwd) -type d -name node_modules -maxdepth 8 -prune -exec tmutil addexclusion {} \; -exec tmutil isexcluded {} \;)
