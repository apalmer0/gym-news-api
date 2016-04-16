#!/bin/bash

curl --include --request POST https://fathomless-castle-93150.herokuapp.com/sign-in \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "an@example.email",
      "password": "an example password"
    }
  }'
