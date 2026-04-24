#!/bin/bash
# This script will report server performance stats

# Capture the CPU idle percentage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print 100 - $1"%"}')

# Get Memory stats in MB
stats=$(free -m | awk 'NR==2{printf "%s %s %s", $2, $3, $4}')

# Read the values into variables
read total used free <<< "$stats"

# Calculate percentage using awk for decimal support
percent=$(awk "BEGIN {printf \"%.2f\", ($used/$total)*100}")

# Get current disk space used, free  and usage
disk=$(df -h / | awk 'NR==2{printf "| Used: %s | Free: %s | Usage: %s |\n", $3, $4, $5}')

echo "--------------------------"
echo "Current CPU Usage:" ${cpu_idle}
echo "Memory Total:" ${total}MB
echo "Memory Usage:" ${percent}%
echo "Disk Stats:" ${disk}
echo "--------------------------"