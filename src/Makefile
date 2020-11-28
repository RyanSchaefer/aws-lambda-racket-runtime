build-%:
	docker build . -t build-env:latest \
	&& docker run -v $(ARTIFACTS_DIR)/:/artifacts_dir -v $(shell pwd)/:/build build-env:latest
