function cleanup()
{
    service apache2 stop
    service mysql stop
    # redis and tcsh don't need graceful cleanup (I hope)

    echo "exited $0"
    exit
}

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap cleanup HUP INT QUIT TERM

service apache2 start
service mysql start
redis-server --daemonize yes
# Start up movie builder
nohup tcsh /var/www-api/api.helioviewer.org/scripts/movie_queue.tcsh > /var/www-api/api.helioviewer.org/log/movie_builder.log

echo "[hit enter key to exit] or run 'docker stop <container>'"
read
