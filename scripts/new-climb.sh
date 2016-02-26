#!/bin/bash

curl --include --request POST http://localhost:3000/climbs \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
      "color": "TEST",
      "grade": "TEST",
      "modifier": "TEST"
    }'
