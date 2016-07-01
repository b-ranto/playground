# Process this file with cmake to produce a Makefile.
# cmake .

PROJECT(slovnik C)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

SET(CMAKE_C_FLAGS "-O3")

INCLUDE_DIRECTORIES(src)

ADD_SUBDIRECTORY(src)
