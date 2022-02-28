import qbs

DynamicLibrary {
  name: "CuteLogger"
 Group {
      name: "CuteLoggerGroup"
  files: [ "src/*", "include/*" ]
  excludeFiles: [ "src/OutputDebugAppender.*","include/OutputDebugAppender.h", "src/AndroidAppender.*" ]
}
 /*
  Group {
    name: "windows-OutputDebugAppender"

    condition: qbs.targetOS == "windows"
    files: [ "src/OutputDebugAppender.cpp", "include/OutputDebugAppender.h" ]
  }
  */

  Depends { name: "cpp" }
  cpp.includePaths: "include"
  cpp.defines: "CUTELOGGER_LIBRARY"

  Depends { name: "Qt.core" }

  Export {
    Depends { name: "cpp" }
    cpp.includePaths: "include"
  }

  Group {
    qbs.install: true
    //qbs.installDir: "lib"
    fileTagsFilter: product.type
    //fileTagsFilter: "dynamiclibrary"
  }
}
