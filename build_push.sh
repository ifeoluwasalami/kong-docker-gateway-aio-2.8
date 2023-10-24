set -ex

docker build --pull \
 --tag ebberst/kong31-wallarm:latest .
docker push ebberst/kong31-wallarm:latest
