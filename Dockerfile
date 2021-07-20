FROM debian:buster-slim

RUN apt-get update \
 && apt-get install -y certbot nginx socat tor wget

ARG YQ_VERSION=v4.11.1
ARG YQ_BINARY=yq_linux_amd64
RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -O /usr/bin/yq \
 && chmod +x /usr/bin/yq

COPY ./nginx/snippets/* /etc/nginx/snippets/
COPY ./nginx/templates/* /etc/nginx/templates/

COPY ./entrypoint /bin/entrypoint
RUN chmod +x /bin/entrypoint

ENTRYPOINT [ "/bin/entrypoint" ]