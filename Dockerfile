FROM golang:buster 

WORKDIR /
COPY . /arena-store
#RUN rm /arena-store/database.db /arena-store/*filebrowser* || true
WORKDIR /arena-store
RUN go mod download
WORKDIR /arena-store/http
RUN go get github.com/GeertJohan/go.rice/rice
RUN go build github.com/GeertJohan/go.rice/rice
RUN ./rice embed-go
WORKDIR /arena-store
RUN go build -a -o arena-store 

VOLUME /srv/users
EXPOSE 8080

COPY startup.sh /startup.sh
RUN mv /arena-store/docker-config.json /arena-store/.config.json 

ENTRYPOINT [ "/bin/bash", "-c", "/startup.sh" ]
