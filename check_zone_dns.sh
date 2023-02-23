#!/bin/bash
#
# Check if a DNS zone is correctly set compared to its known value.
#
# Copyright (c) [2023] [Hervé BONTEMPS]
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

if [ $# -lt 3 ]; then
    echo "Usage: $0 <zone (subdomain or domain)> <zone type (A TXT OR MX)> <expected value> [value type, e.g. google spf]"
    exit 1
fi

# Assigning variables for easier reference later on
zone="$1"
zone_type="$2"
expected_result="$3"
content_type="$4"

if [ "$zone_type" == "A" ]; then
    # Get the IP address for the given domain
    actual_result=$(dig +short A "$zone" | tail -n1)
elif [ "$zone_type" == "MX" ]; then
    # Get the mail server for the given domain
    actual_result=$(nslookup -type=mx "$zone" | awk '/^'$zone'/ {sub(/\.$/, "", $NF); print $NF}')
else
    # Get the TXT record(s) for the given domain and content type (if specified)
    # In the case where we have multiple TXT records for the same domain, we need to check the content type as well
    if [ -z "$content_type" ]; then
        actual_result=$(nslookup -type=txt "$zone" | awk -F'"' '/^'$zone'/ {print $2}')
    else
        actual_result=$(nslookup -type=txt "$zone" | awk -F'"' -v type="$content_type" '/^'$zone'/ {if ($2 ~ type) print $2}')
    fi
fi

# Compare the expected and actual results
if [ "$expected_result" != "$actual_result" ]; then
    # If the results don't match, exit with success status code
    exit 0
else
    # If the results match, exit with error status code
    exit 1
fi
