# ARENA Store

Fork of [filebrowser](https://github.com/filebrowser/filebrowser) to provide a file management interface for the ARENA Store. We configured filebrowser to provide each user its own directory, and performed minor adaptations to create a home user skeleton and default ARENA branding.

## Organization

Each user can create subfolders which then are visible for ARENA scenes under **[ARENA URL]/store/**.

````
home/                     <-- 'My Files' (user1)
   |-models
       |-Suzanne.gltf      <-- file available at [ARENA URL]/store/models/Suzanne.gltf
   |-hello-world/          <-- program 'hello-world', available unde
````

For example, the file ```My Files/models/Suzanne.gltf``` is available for ARENA scenes under the url ```[ARENA URL]/store/users/user1/models/Suzanne.gltf```.

When referencing programs (detailed [below](store-for-arena-programs)) we use a **namespace**/**program-name** combination. E.g. (based on the example folder structure above) ```user1/hello-world``` will reference to the program under ```My Files/hello-world``` for user **user1**. See [Section](store-for-arena-programs) for details.

## Store for ARENA Programs 

Programs can then be referecenced using a **namespace**/**program-name** combination, where the **namespace** is the user used to access the ARENA store and **program-name** is folder name under ```My Files/```. 

Each program folder has the files:

- ```binary-file-name .wasm | .py```: the binary file of the program; can be a .wasm (Web Assembly) file or a .py (Python).
- ```requirements.txt```: if a Python program
- *Optional* source files

For example:
````
|-home/
   |-hello-world/               <-- program 'hello-world'
   |    |-hello-world.c
   |    |-Makefile
   |    |-hello-world.wasm
   |
   |-prgrm1/                    <-- program 'prgrm1'
   |    |-prgrm1.wasm
   |
   |-prgrm2/                    <-- program 'prgrm2'
       |-prgrm2.py
       |-requirements.py
````

## Quick Setup

See [filebrowser documentation](https://filebrowser.org/) for details.

### From docker

You have to map the folder ```/srv-files``` where the files to be served will be on the host, and the folder where data (```/arena-store/data ```; e.g. the database) will be stored:
```
docker run -it \
    -v /path/to/users-home-files-root:/srv-files \
    -v /path/to/data-folder:/arena-store/data \
    -p 8080:8080 \
    conixcenter/arena-store
```

e.g., in Linux/Mac:
```
docker run -it -v $(PWD)/srv:/srv-files -v $(PWD)/docker-data:/arena-store/data -p 8080:8080 conixcenter/arena-store
```

**Notes**:
- The user home files are located under ```/srv/users```, and this should be mapped to some folder in the host (``` -v /path/to/users-home-files-root:/srv/users```); 
- A default user home skeleton is located under ```/srv/user-skel```; you can create your own user home skeleton on the host and map it by adding ``` -v /path/to/users-home-skel:/srv/user-skel```;
- If you don't already have a ```database.db``` file, make sure to create a new empty file (```touch path/to/database.db```) under the path you specified. 

### From source

- Clone the repo

- Build assets and binary:
```
./wizard.sh -b
```

- Start filebrowser
```
filebrowser -r /path/to/your/files
```

### Build the container 
```
./wizard.sh -d
```
