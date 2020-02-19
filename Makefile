BUILD_ARGS?=
BUILD_PLATFORM?=linux/arm/v7,linux/arm64/v8,linux/amd64,linux/ppc64le,linux/s390x
BUILDX_VERSION=v0.3.1
IMAGE_TAG?=$(shell date +%Y%m%d)
NAMESPACE?=jdrouet

build:
	docker buildx build ${BUILD_ARGS} \
		--platform ${BUILD_PLATFORM} \
		-t ${NAMESPACE}/gatsby:${IMAGE_TAG} \
		.

build-latest:
	docker buildx build ${BUILD_ARGS} \
		--platform ${BUILD_PLATFORM} \
		-t ${NAMESPACE}/gatsby:${IMAGE_TAG} \
		-t ${NAMESPACE}/gatsby:latest \
		.

test:
	docker build -t ${NAMESPACE}/gatsby:local .
	docker build -t ${NAMESPACE}/gatsby-test:local -f test.Dockerfile .

install-buildx:
	mkdir -vp ~/.docker/cli-plugins/ ~/dockercache
	curl --silent -L "https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx create --use --platform ${BUILD_PLATFORM}
	docker buildx inspect
