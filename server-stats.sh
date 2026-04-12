#!/bin/bash

# Capture the CPU idle percentage
cpu_idle=$(top -bn 1 | grep "Cpu(s)" | sed 's/[a-z,:%]//g' | awk '{print $8}')

# Calculate CPU used percentage (100 - idle)
cpu_usage=$(awk "BEGIN {print (100 - $cpu_idle)}")

# Get Memory stats in MB
stats=$(free -m | awk 'NR==2{printf "%s %s %s", $2, $3, $4}')

# Read the values into variables
read total used free <<< "$stats"

# Calculate percentage using awk for decimal support
percent=$(awk "BEGIN {printf \"%.2f\", ($used/$total)*100}")

echo "--------------------------"
echo "Current CPU Usage: $cpu_usage%"
echo "Memory Total: ${total}MB"
echo "Memory Usage: ${percent}%"
echo "--------------------------"
