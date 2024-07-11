FROM python:3.8.0-alpine

WORKDIR /app
COPY . .

RUN apk --no-cache --update add build-base \
                                pkgconf \
                                mariadb-dev \
                                mariadb-connector-c-dev  && \
    pip install --upgrade pip && \
    pip install -r /app/requirements.txt && \
    apk del build-base

ENV MYSQL_HOST "db"
ENV FLASK_CONFIG "mysql"

ENTRYPOINT [ "gunicorn", "-b", "0.0.0.0", "appy:app" ]