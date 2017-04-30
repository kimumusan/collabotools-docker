FROM java:8-jre

RUN apt-get update && apt-get -y install netcat

ADD "https://github.com/gitbucket/gitbucket/releases/download/4.9/gitbucket.war" "/opt/gitbucket.war"

RUN ln -s /gitbucket /root/.gitbucket

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
