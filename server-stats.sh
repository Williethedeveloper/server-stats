#!/bin/bash

echo "============================"
echo "📊 Server Performance Stats"
echo "============================"

# 1️⃣ CPU Usage (Fixed)
echo ""
echo "🔥 CPU Usage:"
if command -v mpstat &> /dev/null
then
    mpstat | awk '/all/ {print "CPU Usage: " 100-$NF "%"}'
else
    echo "mpstat command not found! Install it with: sudo apt install sysstat"
fi

# 2️⃣ Memory Usage (Fixed)
echo ""
echo "🧠 Memory Usage:"
free -b | awk 'NR==2{printf "Used: %.2fGB / Total: %.2fGB (%.2f%%)\n", $3/1073741824, $2/1073741824, $3/$2 * 100}'

# 3️⃣ Disk Usage
echo ""
echo "💾 Disk Usage:"
df -h --total | awk '/total/ {printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $5}'

# 4️⃣ Top 5 CPU-hungry processes (Better version)
echo ""
echo "⚡ Top 5 CPU-hungry processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

# 5️⃣ Top 5 Memory-hungry processes (Better version)
echo ""
echo "🛑 Top 5 Memory-hungry processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -6

# 6️⃣ Extra System Info
echo ""
echo "🔍 Extra System Info:"
echo "OS Version: $(lsb_release -d | cut -f2-)"
echo "Uptime: $(uptime -p)"
echo "Logged-in users: $(who | wc -l)"

echo "============================"
echo "✅ Analysis Complete!"
echo "============================"
