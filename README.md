cmake-example-library
=====================

CMake library example that can be found using `find_package()`.

**Update:** now using modern cmake (version >= 3.9), since commit [46f0b93](https://github.com/pablospe/cmake-example-library/commit/46f0b93e9725588d344f9b3231c6da77ea11a1bc).


### Features

  * The main **advantage** of this example is that it is _auto-generated_.
    You only need to change the _project name_, and add the files that need to
    be compiled in [foo/CMakeLists.txt](foo/CMakeLists.txt).

  * Autogenetared library version file: `#include <foo/version.h>`

  * `FOO_DEBUG` added on Debug. See [foo/foo.cpp#L7-L11](foo/foo.cpp#L7-L11).

  * `CMAKE_DEBUG_POSTFIX = 'd'` (allowing `Debug` and `Release` to not collide).
     See [cmake/SetEnv.cmake#L17](cmake/SetEnv.cmake#L17).

  * Static library as default (`BUILD_SHARED_LIBS=OFF`).
    See [cmake/SetEnv.cmake#L19-L21](cmake/SetEnv.cmake#L19-L21).

  * `cmake-gui` shows possible options for `CMAKE_BUILD_TYPE` (Release, Debug,
    etc.). For _multi-config_ generator, `CMAKE_CONFIGURATION_TYPES` is set
    instead of `CMAKE_BUILD_TYPE`.
    See [cmake/SetEnv.cmake#L23-L48](cmake/SetEnv.cmake#L23-L48).

  * `Uninstall` target.
    See [cmake/SetEnv.cmake#L104-L109](cmake/SetEnv.cmake#L104-L109).

  * Always full RPATH (for shared libraries).
    See [cmake/SetEnv.cmake#L111-L132](cmake/SetEnv.cmake#L111-L132).

  * CMake Registry: export package to CMake registry such that it can be easily found by CMake even if it has not been installed to a standard directory. See [cmake/SetEnv.cmake#L135](cmake/SetEnv.cmake#L135).
  Possible options:
    ```
    -DCMAKE_REGISTRY_FOLDER="OFF"            (disable CMake registry [default])
    -DCMAKE_REGISTRY_FOLDER="INSTALL_FOLDER"
    -DCMAKE_REGISTRY_FOLDER="BUILD_FOLDER"
    ```


### Usage

In this example, `Foo` is the library and `Bar` a binary (which uses the library).


    find_package(Foo <VERSION> REQUIRED)
    target_link_libraries(... Foo::foo)

See [more details](https://github.com/pablospe/cmake-example-library/tree/moderm_cmake#how-to-use-the-library-as-dependency-in-an-external-project) below.


### How to compile?

Assume the following settings:

    project(Foo)
    ...
    set(LIBRARY_NAME foo)   # [optional] generated automatically (in lowercase)
    set(LIBRARY_FOLDER foo) # [optional] generated automatically (in lowercase)

Example of a local installation:

    > mkdir _build && cd _build
    > cmake -DCMAKE_INSTALL_PREFIX=../_install ..
    > cmake --build . --target install -j 8
      (equivalent to  'make install -j8' in linux)

Installed files:

    > tree ../_install

    ├── bin
    │   └── bar
    ├── include
    │   └── foo
    │       ├── foo.h
    │       └── version.h
    └── lib
        ├── cmake
        │   └── Foo
        │       ├── FooConfig.cmake
        │       ├── FooConfigVersion.cmake
        │       ├── FooTargets.cmake
        │       ├── FooTargets-debug.cmake
        │       └── FooTargets-release.cmake
        ├── libfoo.a                             (Release)
        └── libfood.a                            (Debug)

Uninstall library:

    > make uninstall


#### Compilation scripts

Please check the following files for more complex compilation examples:
  - [build_linux.sh](build_linux.sh)
  - [build_win.sh](build_win.sh)
  - [build_ninja.sh](build_ninja.sh)


### Static vs Shared

By default, a static library will be generated. Modify `BUILD_SHARED_LIBS` in
order to change this behavior. For example,

    > cd _build/
    > cmake -DBUILD_SHARED_LIBS=ON ..



### How to use the library (internally in subfolders)?

See the [example of internal subfolder](example_internal/).


### How to use the library (as dependency) in an external project?

See the [example of external project](example_external/).
Once the library is intalled, cmake would be able to find it using
`find_package(...)` command.

    cmake_minimum_required(VERSION 3.9)
    project(Bar)

    find_package(Foo 1.2.3 REQUIRED)

    add_executable(bar bar.cpp)
    target_link_libraries(bar PRIVATE Foo::foo)

Requirements will propagate automatically:
  * `Foo::foo` will link automatically,
  * headers can be included by C++ code like `#include <foo/foo.h>`,
  * `FOO_DEBUG=1` added on Debug,
  * `FOO_DEBUG=0` added otherwise.


### How to use the library as submodule (using add_subdirectory)?

If `Foo` library is intended to be use as a Git submodule:

    > git submodule add https://github.com/<user>/Foo Foo

In the `CMakeLists.txt` where the `Foo` submodule will be used,
add the command **add_subdirectory(...)**:

    [...]

    # Add 'Foo' library as submodule
    add_subdirectory(Foo)

    # Propagate usage requirements from Foo linked library
    target_link_libraries(<target> PRIVATE Foo::foo)

    [...]


### How to create a library from this example?

Follow these steps:

  * Copy files in a new folder, or clone with git:

    > git clone git@github.com:pablospe/cmake-example-library.git

  * Change project name in the top-level `CMakeLists.txt`.

  * Add `.cpp` and `.h` files in `foo/CMakeLists.txt`.

  * [Optional] Set variables: `LIBRARY_NAME` and `LIBRARY_FOLDER`.
    If it is not set explicitally, project name in lowercase will be used.
    See [cmake/SetEnv.cmake](cmake/SetEnv.cmake) file for implementation details.

  * [Optional] 'example_internal/' folder can be removed, it is the 'bar'
    example. In this case, remove the 'add_subdirectory(example_internal)' too.


### Documentation

Some ideas from:
  * https://github.com/forexample/package-example

Modern CMake tutorials (youtube):
  * C++Now 2017: Daniel Pfeifer
    [Effective CMake](https://www.youtube.com/watch?v=bsXLMQ6WgI)
  * CppCon 2018: Mateusz Pusz
    [Git, CMake, Conan - How to ship and reuse our C++ projects](https://www.youtube.com/watch?v=S4QSKLXdTtA)
