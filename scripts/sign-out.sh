#!/bin/bash

curl --include --request DELETE http://localhost:3000/sign-out/2 \
  --header "Authorization: Token token=e7bd55829c6c1199c37267e9d408d01f"
