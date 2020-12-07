#!/bin/bash
# ------------------------------------------------------------
# Bash script to check processes.
# ------------------------------------------------------------
# RETURN CODE
#    0: processes are not running.
#    1: one process is running. (CPU time <  configured value)
#    2: one process is running. (CPU time >= configured value)
#    3: more than two processes are running.
# ------------------------------------------------------------
#
PS_NAME="<process_name>"
CPU_MAX=000100  # Format: `HHMMSS`

# Process counts
CNT=`ps -ef | grep -e "$PS_NAME" | grep -v grep | wc -l`

if [ $CNT -eq 0 ]; then
    echo "[RET-CODE:0] processes are not running."
    exit 0
elif [ $CNT -eq 1 ]; then
    # CPU time
    TM=`ps -ef | grep -e "$PS_NAME" | grep -v grep | awk '{ print $7 }'`
    TM=${TM:0:2}${TM:3:2}${TM:6:2}

    if [ $TM -lt $CPU_MAX ]; then
        echo "[RET-CODE:1] one process is running. (CPU time <  configured value)"
        exit 1
    else
        echo "[RET-CODE:2] one process is running. (CPU time >= configured value)"
        exit 2
    fi
else
    echo "[RET-CODE:3] more than two processes are running."
    exit 3
fi
