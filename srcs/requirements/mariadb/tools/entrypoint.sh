#!/bin/bash
mysqld_safe &

sleep 10

/build.sh

wait
