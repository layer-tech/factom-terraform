#!/bin/bash

BLOCK_HEIGHT=$(curl  -sb -H "Accept: application/json"  http://localhost:8088/v1/directory-block-height/ | jq ".Height")
echo "block_height $BLOCK_HEIGHT" > /var/prom_exports/data/block_height.prom
