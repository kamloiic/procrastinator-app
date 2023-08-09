DOCKER_IMAGE_NAME := tl-backend
DOCKER_IMAGE_TAG := latest
CONTAINER_REGISTRY := your-container-registry-url

.PHONY: build push

build:
	@echo "Building image using Cloud Native Buildpacks..."
	pack build $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) --builder heroku/buildpacks

push:
	@echo "Pushing Docker image to $(CONTAINER_REGISTRY)..."
	docker tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) $(CONTAINER_REGISTRY)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
	docker push $(CONTAINER_REGISTRY)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

deploy: build push

clean:
	docker rmi $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) || true

.PHONY: deploy-postgres deploy-backend

deploy-postgres:
	kubectl create namespace tl-ns
	kubectl apply -f kubernetes/postgres.yaml -n tl-ns

deploy-backend:
	kubectl apply -f kubernetes/backend.yaml -n tl-ns

deploy-k: deploy-postgres deploy-backend

.PHONY: clean

clean-k:
	kubectl delete service/postgres-service -n tl-ns
	kubectl delete deployment.apps/postgres-deployment -n tl-ns
	kubectl delete service/backend-service -n tl-ns
	kubectl delete deployment.apps/backend-deployment -n tl-ns
	kubectl delete namespace tl-ns

undeploy: 
	docker rmi $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) || true
	kubectl delete service/postgres-service -n tl-ns
	kubectl delete deployment.apps/postgres-deployment -n tl-ns
	kubectl delete service/backend-service -n tl-ns
	kubectl delete deployment.apps/backend-deployment -n tl-ns
	kubectl delete namespace tl-ns