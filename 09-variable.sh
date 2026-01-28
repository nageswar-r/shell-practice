#!/bin/bash

echo "All args passed to script: $@"
echo "Number of vars passed to script: $#"
echo "Script name: $0"
echo "Present directory: $PWD"
echo "Who is running: $USER"
echo "PID of this script: $$"
sleep 100 &
echo "PID of recently executed background process: $!"
echo "All args passed to scripts: $*"