## Homework 16


### Доп задание 1. MongoDB exporter

Для этой задачи был использован percona exporter.

Результат в docker-compose:
```yml
mongo-exporter:
  image: percona/mongodb_exporter:0.20
  ports:
    - '9216:9216'
  command:
    - '--mongodb.uri=mongodb://mongo_db:27017'
  networks:
    - back_net
```

Конфигурация prometheus:
```yml
- job_name: 'mongo'
  static_configs:
    - targets:
      - 'mongo-exporter:9216'
```

### Доп задание 2. Blackbox exporter

Был использован официальный blackbox exxporter и обычная http проба, настроенная через конфиг prometheus
```yml
blackbox-exporter:
  image: prom/blackbox-exporter
  ports:
    - '9115:9115'
  networks:
    - back_net
```

Конфигурация prometheus:
```yml
- job_name: 'blackbox'
  metrics_path: /probe
  params:
    module: [http_2xx]  # Look for a HTTP 200 response.
  static_configs:
    - targets:
      - http://ui:9292
      - http://comment:9292
      - http://post:5000
  relabel_configs:
    - source_labels: [__address__]
      target_label: __param_target
    - source_labels: [__param_target]
      target_label: instance
    - target_label: __address__
      replacement: blackbox-exporter:9115  # The blackbox exporter's real hostname:port.
```

### Доп задание 3. Makefile для образов докера

Был создан простой [Makefile](../../src/Makefile), включающий в себя возможность сборки и отравки образов как каждого из образов по отдельности, так и всех сразу. Так же подтягивает переменные из ранее созданного .env файла.

```Makefile
include .env


all: post comment ui prometheus


post: build_post push_post

comment: build_comment push_comment

ui: build_ui push_ui

prometheus:	build_prometheus push_prometheus


build_post:
	docker build -t ${IMAGE_USERNAME}/post:${POST_VERSION} ./post-py

push_post:
	docker push ${IMAGE_USERNAME}/post:${POST_VERSION}


build_comment:
	docker build -t ${IMAGE_USERNAME}/comment:${COMMENT_VERSION} ./comment

push_comment:
	docker push ${IMAGE_USERNAME}/comment:${COMMENT_VERSION}


build_ui:
	docker build -t ${IMAGE_USERNAME}/ui:${UI_VERSION} ./ui

push_ui:
	docker push ${IMAGE_USERNAME}/ui:${UI_VERSION}


build_prometheus:
	docker build -t ${IMAGE_USERNAME}/prometheus:${PROMETHEUS_VERISION} ../monitoring/prometheus

push_prometheus:
	docker push ${IMAGE_USERNAME}/prometheus:${PROMETHEUS_VERISION}
```
