include ../../../make.inc

build_docker_image:
	docker build -t "$(DOCKER_IMAGE_NAME):$(IMAGE_TAG)" -f Dockerfile .

run_docker_image:
	docker run --rm -it -p 8000:$(PORT) -e PORT=$(PORT) "$(DOCKER_IMAGE_NAME):$(IMAGE_TAG)"

tag_docker_image:
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME):$(IMAGE_TAG)

push_docker_image:
	docker push "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME):$(IMAGE_TAG)"

deploy_docker_image:
	gcloud run deploy $(DOCKER_IMAGE_NAME) \
    --image "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME):$(IMAGE_TAG)" \
    --platform managed \
    --region $(LOCATION) \
    --allow-unauthenticated \
		--port $(PORT)
