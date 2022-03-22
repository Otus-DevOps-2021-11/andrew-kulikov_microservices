```bash
docker build -t andrewmachine/post:1.0 ./post-py
docker run -d --network=reddit --network-alias=post andrewmachine/post:1.0

Requested MarkupSafe>=2.0 but installing version None


docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db --name mongo_db mongo:latest
docker run -d --network=reddit --network-alias=post -e POST_DATABASE_HOST=post_db --name post andrewmachine/post:1.0
docker run -d --network=reddit --network-alias=comment -e COMMENT_DATABASE_HOST=comment_db --name comment andrewmachine/comment:3.0
docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST=post -e COMMENT_SERVICE_HOST=comment --name ui andrewmachine/ui:3.0


docker run -d --network=back_net --network-alias=post_db --network-alias=comment_db --name mongo_db mongo:latest
docker run -d --network=back_net --network-alias=post -e POST_DATABASE_HOST=post_db --name post andrewmachine/post:1.0
docker run -d --network=back_net --network-alias=comment -e COMMENT_DATABASE_HOST=comment_db --name comment andrewmachine/comment:3.0
docker run -d --network=front_net -p 9292:9292 -e POST_SERVICE_HOST=post -e COMMENT_SERVICE_HOST=comment --name ui andrewmachine/ui:3.0
docker network connect front_net post
docker network connect front_net comment

docker build -t andrewmachine/post:1.0 ./post-py
docker build -t andrewmachine/ui:1.0 ./ui
docker build -t andrewmachine/comment:1.0 ./comment
```
