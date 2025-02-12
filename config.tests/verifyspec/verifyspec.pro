SOURCES = verifyspec.cpp

# Provide a function to be used by mkspecs
defineTest(deviceSanityCheckCompiler) {
    equals(QMAKE_HOST.os, Windows)|equals(QMAKE_HOST.os, OS/2): \
        sfx = .exe
    else: \
        sfx =

    # Build the compiler filename using the first value in QMAKE_CXX in order to
    # support tools like ccache, which give QMAKE_CXX values of the form:
    #     ccache <path_to_compiler>
    compiler = $$first(QMAKE_CXX)$$sfx

    # Check if the binary exists with an absolute path. Do this check
    # before the CROSS_COMPILE empty check below to allow the mkspec
    # to derive the compiler path from other device options.
    exists($$compiler): return()

    # Check for possible reasons of failure
    # check if CROSS_COMPILE device-option is set
    isEmpty(CROSS_COMPILE): \
        error("CROSS_COMPILE needs to be set via -device-option CROSS_COMPILE=<path>")

    # Check if QMAKE_CXX points to an executable.
    ensurePathEnv()
    for (dir, QMAKE_PATH_ENV) {
        exists($$dir/$${compiler}): \
            return()
    }

    # QMAKE_CXX does not point to a compiler.
    error("Compiler $$QMAKE_CXX not found. Check the value of CROSS_COMPILE -device-option")
}

defined(qtConfSanitizeMkspec, test): \
    qtConfSanitizeMkspec()
