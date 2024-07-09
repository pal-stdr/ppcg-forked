echo "Cleaning up old automake configs\n"
./cleanup.sh

echo "Now running core autogen.h\n"
./autogen.sh

echo "Now running core ./build-ppcg-with-llvm.sh\n"
./build-ppcg-with-llvm.sh


# git submodule add -b v1.7.18-for-ppcg --name cjson https://github.com/pal-stdr/cJSON-forked.git cjson

# git init


# # Add openscop (Used by pluto 0.12.0)
# git submodule add --name osl https://github.com/periscop/openscop.git osl
# cd osl
# git fetch --tags
# git checkout tags/0.9.7
# cd ..



# # Add nlohmann/json ()
# git submodule add --name json https://github.com/nlohmann/json.git json
# cd json
# git fetch --tags
# git checkout tags/v3.11.3
# cd ..