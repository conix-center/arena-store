FROM golang:buster 

WORKDIR /
COPY . /arena-store
RUN rm /arena-store/database.db /arena-store/*filebrowser* || true
WORKDIR /arena-store
RUN go mod download
WORKDIR /arena-store/http
RUN go get github.com/GeertJohan/go.rice/rice
RUN go build github.com/GeertJohan/go.rice/rice
RUN ./rice embed-go
WORKDIR /arena-store
RUN go build -a -o arena-store 
RUN touch database.db
#FROM buster

#COPY . /arena-store
#COPY frontend/dist /arena-store/frontend/dist
#COPY --from=build /arena-store/arena-store /arena-store/arena-store

VOLUME /srv/users
EXPOSE 80

#COPY arena-store.json /arena-store/arena-store.json

RUN /arena-store/arena-store config import /arena-store/arena-store-settings.json

COPY srv/user-skel /srv/user-skel

#ENTRYPOINT [ "arena-store/arena-store" ]
