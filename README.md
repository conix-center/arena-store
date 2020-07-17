# ARENA Scene and Code Store

Fork of [filebrowser](https://github.com/filebrowser/filebrowser) to provide a file managing interface. We configured filebrowser to provide each user its own directory, and performed minor adaptations to create a home user skeleton and default ARENA branding.

## Organization

Each home user store has ```scenes``` and ```code```. Users can create subfolders under ```scenes``` and ```code``` which then can be used in any ARENA realm.

````
home/                          <-- 'My Files'
   |-scenes/
   |    |-hello/               <-- scene 'hello'
   |-code/
       |-hello-world/          <-- program 'hello-world'   
````

When the ARENA loads a scene, it looksup scene init files under the respective scene folder in the store, given a *namespace*, defined by the user used to login in the ARENA scene/code store. E.g.:

**https://xr.andrew.cmu.edu/index.html?scene=hello&ns=user1**

Will lookup the files under ```My Files/scenes/hello``` of the ARENA scene/code store for user **user1**.

Em referencing programs in config files (detailed below) we use a **namespace**/**program-name** combination. E.g. (based on the example folder structure above) ```user1/hello-world``` will reference to the program under ```My Files/code/hello-world``` for user **user1**. See [Section](Code) for details.

## Scene Definition/Config

Each scene folder is assumed to have two files:

- ```scene.html```: an [aframe](https://aframe.io/) scene with the inital static scene objects. This file should only contain the scene (see example below)
- ```config.json```: a json config file that configures the scene, including programs to be loaded and visual tags used in the scene  (see example below). 

````
|-scenes/
   |-hello/               <-- scene 'hello'
   |   |-scene.html
   |   |-config.json
   |
   |-duck/               <-- scene 'duck'
       |-scene.html
       |-config.json
````

### Example scene.html and config.json

#### scene.html

```html
<!-- this file should have *only* an aframe scene with the inital static scene objects -->
<a-scene background="color: #FAFAFA">
     <a-box position="-1 0.5 -3" rotation="0 45 0" color="#4CC3D9" shadow></a-box>
     <a-sphere position="0 1.25 -5" radius="1.25" color="#EF2D5E" shadow></a-sphere>
     <a-cylinder position="1 0.75 -3" radius="0.5" height="1.5" color="#FFC65D" shadow></a-cylinder>
</a-scene>
```

#### config.json

This file contains config information about the scene. For now, that includes visual tags used by the scene and programs to be loaded.

```json
{
    "programs": [ 
      { "name":"user1/hello-world" },
      { "name":"user2/uwb-solver" } 
    ] 
}
```

The example shows programs indicated by name, using a **namespace**/**program-name** combination (see the following section).

## Code

The code folder has subfolders for each program. The folder name identifies the program. Programs can then be referecenced using a **namespace**/**program-name** combination, where the **namespace** is the user used to access the ARENA scene/code store and **program-name** is folder name under ```My Files/code/```. 

Each program folder has the files:

- ```config.json```: a json config file that configures the scene, including programs to be loaded and visual tags used in the scene  (see example below)
- ```binary-file-name .wasm | .py```: the binary file of the program; can be a .wasm (Web Assembly) file or a .py (Python).
- ```requirements.txt```: if a Python program
- *Optional* source files

````
|-code/
   |-hello-world/               <-- program 'hello-world'
   |    |-hello-world.c
   |    |-Makefile
   |    |-config.json	
   |    |-hello-world.wasm
   |
   |-prgrm1/                    <-- program 'prgrm1'
   |    |-prgrm1.wasm
   |    |-config.json
   |
   |-prgrm2/                    <-- program 'prgrm2'
       |-prgrm2.py
       |-requirements.py
       |-config.json        
````

### Example config.json 

```json
{
  "name":"hello-world",
  "filename":"hello-world.wasm",
  "filetype":"WA",
  "args":[ "arg1", "arg2"],
  "env":[ "ENV_VAR1=1", "ENV_VAR2=2" ],
  "channels":[ ]
 }
```

Where:
- **name**: name of the program
- **filename**: the entry binary file
- **filetype**: one of Web Assembly ("WA") or Python ("PY")
- **args**: list of command-line arguments passed to the program
- **env**: list of environment variables passed to the program
- **channels**: list of (communication; mqtt or client sockets) channels the program has access to (only suppported for WASM programs)

## Quick Setup

See [filebrowser documentation](https://filebrowser.org/) for details.

### From docker

```
docker run \
    -v /path/to/users-home-files-root:/srv/users \
    -v /path/database.db:/database.db \
    -p 80:80 \
    conixcenter/arena-store
```

**Notes**:
- The user home files are located under ```/srv/users```, and this should be mapped to some folder in the host (``` -v /path/to/users-home-files-root:/srv/users```); 
- A default user home skeleton is located under ```/srv/user-skel```; you can create your own user home skeleton on the host and map it by adding ``` -v /path/to/users-home-skel:/srv/user-skel```;
- If you don't already have a ```database.db``` file, make sure to create a new empty file under the path you specified. 

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
