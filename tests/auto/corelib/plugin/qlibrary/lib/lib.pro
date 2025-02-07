TEMPLATE = lib
CONFIG += dll
CONFIG -= staticlib
SOURCES		= mylib.c
TARGET = mylib
DESTDIR = ../
QT = core

msvc: DEFINES += WIN32_MSVC

# This project is testdata for tst_qlibrary
target.path = $$[QT_INSTALL_TESTS]/tst_qlibrary
INSTALLS += target

win32|os2:debug_and_release {
    CONFIG(debug, debug|release) {
        DESTDIR = ../debug/
    } else {
        DESTDIR = ../release/
    }
}
