FROM python:3.6.0-alpine

WORKDIR /app
COPY . /app

# hadolint ignore=DL3018
RUN apk add --no-cache --virtual .build-deps gcc libffi-dev libc-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps gcc libffi-dev libc-dev

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

CMD ["python3", "post_app.py"]
