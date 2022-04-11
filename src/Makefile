include .env


all: post comment ui prometheus


post: build_post push_post

comment: build_comment push_comment

ui: build_ui push_ui

prometheus:	build_prometheus push_prometheus


build_post:
	docker build -t ${IMAGE_USERNAME}/post:${POST_VERSION} ./post-py

push_post:
	echo 'push ${IMAGE_USERNAME}/post:${POST_VERSION}'
	# docker push ${IMAGE_USERNAME}/post:${POST_VERSION}


build_comment:
	docker build -t ${IMAGE_USERNAME}/comment:${COMMENT_VERSION} ./comment

push_comment:
	echo 'push ${IMAGE_USERNAME}/comment:${COMMENT_VERSION}'
	# docker push ${IMAGE_USERNAME}/comment:${COMMENT_VERSION}


build_ui:
	docker build -t ${IMAGE_USERNAME}/ui:${UI_VERSION} ./ui

push_ui:
	echo 'push push ${IMAGE_USERNAME}/ui:${UI_VERSION}'
	# docker push ${IMAGE_USERNAME}/ui:${UI_VERSION}


build_prometheus:
	docker build -t ${IMAGE_USERNAME}/prometheus:${PROMETHEUS_VERISION} ../monitoring/prometheus

push_prometheus:
	echo 'push push ${IMAGE_USERNAME}/prometheus:${PROMETHEUS_VERISION}'
	# docker push ${IMAGE_USERNAME}/prometheus:${PROMETHEUS_VERISION}
