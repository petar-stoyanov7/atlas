# Local setup
1. Install `docker` and `docker-compose`.
2. Create and populate `.env` file. Add the values for the following:
```
MYSQL_NAME=mysql_local
MYSQL_PASSWORD={value}
MYSQL_DIR={value}
DOCKER_IP={value}
WEB_NAME=web-server
```
3. Login to docker:\
`docker login`
4. Start the deployment:\
`docker-compose up -d`

## Helper script
If you want to use the helper script, this is how you can use it:\
`/bin/bash ./atlas.sh init`\
This command initializes the script and creates an alias `atlas` - it can be used from any directory.\
`atlas help`\
This shows available commands.

`atlas execute <container> <command>`\
executes command on container. **Container** can be `web` and `mysql`. If `command` is omitted - it will ssh to the container\
`atlas start` - starts the deployment\
`atlas stop` - stops the deployment