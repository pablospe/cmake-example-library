rm -fr _build _install
cmake -S. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="_install"
# cmake -S. -B_build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX="_install"
cmake --build _build --target install -j 8 -- VERBOSE=1

printf "\n\n ----- example_external ----- \n\n "

rm -fr example_external/_build

cmake -Sexample_external/ -Bexample_external/_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install -DFoo_DIR="_install/lib/cmake/Foo/"
cmake --build example_external/_build -j 8
example_external/_build/bar
