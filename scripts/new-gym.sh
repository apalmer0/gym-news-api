#!/bin/bash

curl --include --request POST http://localhost:3000/gyms \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
      "name": "TEST",
      "city": "TEST",
      "state": "TEST"
    }'
