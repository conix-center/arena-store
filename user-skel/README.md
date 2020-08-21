# ARENA Store

Fork of [filebrowser](https://github.com/filebrowser/filebrowser) to provide a file management interface for the ARENA Store. We configured filebrowser to provide each user its own directory, and performed minor adaptations to create a home user skeleton and default ARENA branding.

## Organization

Each user can create subfolders which then are visible for ARENA scenes under **[ARENA URL]/store/**.

````
home/                      <-- 'My Files' (user1)
   |-models
       |-Suzanne.gltf      <-- file available at [ARENA URL]/store/users/user1/models/Suzanne.gltf
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
