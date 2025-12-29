# Local setup
1. Install `docker` and `docker-compose`.
2. Create and populate `.env` file. Add the values for the following:
```
MYSQL_NAME=mysql_local
MYSQL_PASSWORD={value}
MYSQL_DIR={value}
DOCKER_IP={value}
WEB_NAME=
```
3. Login to docker:\
`docker login`
2. Start the deployment:\
`docker-compose up -d`
