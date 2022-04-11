include .env


all: post comment ui


post: build_post push_post

comment: build_comment push_comment

ui: build_ui push_ui


build_post:
	docker build -t ${USER_NAME}/post:${POST_VERSION} ./post-py

push_post:
	echo 'push ${USER_NAME}/post:${POST_VERSION}'
	# docker push ${USER_NAME}/post:${POST_VERSION}


build_comment:
	docker build -t ${USER_NAME}/comment:1.0 ./comment

push_comment:
	echo 'push ${USER_NAME}/comment:${COMMENT_VERSION}'
	# docker push ${USER_NAME}/comment:${COMMENT_VERSION}


build_ui:
	docker build -t ${USER_NAME}/ui:${UI_VERSION} ./ui

push_ui:
	echo 'push push ${USER_NAME}/ui:${UI_VERSION}'
	# docker push ${USER_NAME}/ui:${UI_VERSION}
