#!/bin/bash
# Start MySQL safely
mysqld_safe &

# Wait a little for mysqld to be up and running
sleep 10

# Now run your build script
/build.sh

# Keep the container running
wait
