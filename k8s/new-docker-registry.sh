docker volume create local_registry
docker container run -d --name localregistry -v local_registry:/var/lib/registry --restart always -p 5000:5000 -e REGISTRY_STORAGE_DELETE_ENABLED=true registry:2