#!/bin/bash
#
# This script checks the DNS configuration of a domain's zones using files containing the zones to be checked and the check_zone_dns.sh script.
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


# Get the absolute path of the directory where this script resides
current_dir="$(dirname "$(readlink -f "$0")")"

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Please provide the name of the file containing the zones to be checked as an argument."
    exit 0
fi

# Loop through each zone to be checked
while IFS="|" read -r zone type value type_value; do
    # Call the check_zone_dns.sh script to check the zone
    /bin/bash  "$current_dir/check_zone_dns.sh" "$zone" "$type" "$value" "$type_value" > /dev/null

    # Check if the previous command succeeded or failed
    if [ $? -ne 1 ]; then
        # Store the zone with an error in a variable to be displayed at the end of execution
        zones_en_erreur=$(echo -e "$zones_en_erreur\n- $zone $type $value $type_value")
    fi
done < "$current_dir/zones/$1"

# Display the zones with errors
if [ -n "$zones_en_erreur" ]; then
    echo "The following zones have errors:"
    echo "$zones_en_erreur"
else
    exit 1
fi
