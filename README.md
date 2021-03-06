# Atmosphere Quick-run Bundle

Use the Gradle Wrapper to run the desired component of the Atmosphere framework. Currently supported commands are:
```
./gradlew runServer
```
The `runServer` command will run a [Server](https://github.com/MusalaSoft/atmosphere-server) on a specific port (see `server.properies` file).

```
./gradlew runAgent [-Pip=<ip address of the Server>] [-Pport=<port of the Server>]
```

The `runAgent` task accepts the IP address and port of the Server as arguments to perform automatic connection on startup. If no `ip` argument is provided, the default value will be `localhost`. If no `port` argument is provided, the script will check the `server.properties` file for a port value.

```
./gradlew runUiViewer
```
The `runUiViewer` command will run the [`atmosphere-ui-viewer`](https://github.com/MusalaSoft/atmosphere-ui-viewer).
