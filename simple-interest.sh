#!/usr/bin/env bash
# simple-interest.sh — compute Simple Interest
# Formula: SI = (Principal × Rate × Time) / 100
# Usage: ./simple-interest.sh <principal> <rate> <time>

set -euo pipefail

usage() {
  echo "Usage: $0 <principal> <annual_rate_percent> <time_in_years>"
  echo "Example: $0 10000 7.5 2"
}

# Show help if args missing or -h used
if [[ "${1-}" == "-h" || "${1-}" == "--help" || $# -ne 3 ]]; then
  usage
  exit 1
fi

principal="$1"
rate="$2"
time="$3"

# Validate numeric inputs
num_re='^-?[0-9]+([.][0-9]+)?$'
for v in "$principal" "$rate" "$time"; do
  if ! [[ "$v" =~ $num_re ]]; then
    echo "Error: inputs must be numeric. Got: '$v'" >&2
    usage
    exit 2
  fi
done

# Calculate SI and Total using awk (for decimals)
si=$(awk "BEGIN { printf \"%.2f\", ($principal * $rate * $time)/100 }")
total=$(awk "BEGIN { printf \"%.2f\", $principal + ($principal * $rate * $time)/100 }")

# Output
echo "Principal : $principal"
echo "Rate      : ${rate}%"
echo "Time      : ${time} years"
echo "Simple Interest: $si"
echo "Total Amount   : $total"
