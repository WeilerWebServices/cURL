# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/predef
    REF boost-1.74.0
    SHA512 
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})

file(COPY ${SOURCE_PATH}/tools/check DESTINATION ${CURRENT_PACKAGES_DIR}/share/boost-predef)