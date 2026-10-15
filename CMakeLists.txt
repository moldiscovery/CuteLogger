CMAKE_MINIMUM_REQUIRED(VERSION 3.5)

SET(CMAKE_CXX_STANDARD 17)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)

PROJECT(CuteLogger)

# Qt major version: inherited from the parent project (e.g. Lipostar sets it),
# otherwise detected here, preferring Qt 6
if(NOT DEFINED QT_VERSION_MAJOR)
    find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
endif()

find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core REQUIRED)

ADD_DEFINITIONS(-DCUTELOGGER_LIBRARY)

INCLUDE_DIRECTORIES(BEFORE include)

SET(sources
  src/Logger.cpp
  src/AbstractAppender.cpp
  src/AbstractStringAppender.cpp
  src/ConsoleAppender.cpp
  src/FileAppender.cpp
  src/RollingFileAppender.cpp
)

SET(includes
  include/Logger.h
  include/FileAppender.h
  include/CuteLogger_global.h
  include/ConsoleAppender.h
  include/AbstractStringAppender.h
  include/AbstractAppender.h
  include/RollingFileAppender.h
)


# OutputDebugAppender is only for Windows systems
IF(WIN32)
  SET(sources ${sources} src/OutputDebugAppender.cpp)
  SET(includes ${includes} include/OutputDebugAppender.h)
ENDIF(WIN32)


SET(library_target CuteLogger)

ADD_LIBRARY(${library_target} SHARED ${sources} ${includes})
TARGET_LINK_LIBRARIES(${library_target} Qt::Core)
TARGET_INCLUDE_DIRECTORIES(${library_target} PUBLIC include)


SET(ENABLE_TESTS OFF CACHE BOOL "Enable building CuteLogger tests")
IF (ENABLE_TESTS)
  SET(CMAKE_AUTOMOC ON)
  find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Test REQUIRED)

  ADD_EXECUTABLE(basictest test/basictest.cpp)
  TARGET_LINK_LIBRARIES(basictest Qt::Core Qt::Test CuteLogger)
ENDIF ()

target_compile_definitions(${library_target} PRIVATE CUTELOGGER_LIBRARY)
