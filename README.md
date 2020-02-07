cmake-example-library
=====================

This is an example of how to install a library with CMake, and then use
`find_package()` command to find it.

In this example, Foo is the library and Bar a binary (which uses the library).

The **advantage** of this example is that it is auto-generated. You only need to change
the *project name*.

It is based on the these two examples:
  * [How to create a ProjectConfig.cmake file (cmake.org)]
    (http://www.cmake.org/Wiki/CMake/Tutorials/How_to_create_a_ProjectConfig.cmake_file)
  * [How to install a library (kde.org)]
    (https://projects.kde.org/projects/kde/kdeexamples/repository/revisions/master/show/buildsystem/HowToInstallALibrary)

### How to create a library from this example?

Follow these steps:

  * Copy files in a new folder, or clone with git:

    > git clone git@github.com:pablospe/cmake-example-library.git

  * Change project name in the top-level `CMakeLists.txt`.

  * [Optional] Set variables: `LIBRARY_NAME` and `LIBRARY_FOLDER`.
    If it is not set explicitally, project name in lowercase will be used.
    See `cmake/SetEnv.cmake` file to see the implementation details.

  * [Optional] 'example_internal/' folder can be removed, it is the 'bar' example.
    In this case, remove the 'add_subdirectory(example_internal)' too.

### How to compile?

Assume the following settings:

    project(Foo)
    ...
    set(LIBRARY_NAME foo)   # [optional] generated automatically (in lowercase)
    set(LIBRARY_FOLDER foo) # [optional] generated automatically (in lowercase)

Example of a local installation:

    > mkdir build
    > cd build
    > cmake -DCMAKE_INSTALL_PREFIX=../installed ..
    > make install

Installed files:

    > tree ../installed

    ├── bin
    │   └── bar
    ├── include
    │   └── foo
    │       ├── foo.h
    │       └── version.h
    └── lib
        ├── CMake
        │   └── Foo
        │       ├── FooConfig.cmake
        │       ├── FooConfigVersion.cmake
        │       ├── FooTargets.cmake
        │       └── FooTargets-noconfig.cmake
        └── libfoo.so

Uninstall library:

    > make uninstall

### How to use the library (internally in subfolders)?

See the [example of internal subfolder](example_internal/).

### How to use the library (as dependency) in an external project?

    cmake_minimum_required(VERSION 2.6)
    project(Bar)

    find_package(Foo REQUIRED)
    include_directories(${FOO_INCLUDE_DIRS})

    add_executable(bar bar.cpp)
    target_link_libraries(bar ${FOO_LIBRARIES})

See the [example of external project](example_external/).

