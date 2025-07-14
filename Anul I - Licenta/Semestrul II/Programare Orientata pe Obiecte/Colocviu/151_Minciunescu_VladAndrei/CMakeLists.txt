cmake_minimum_required(VERSION 3.30)
project(151_Minciunescu_VladAndrei)

set(CMAKE_CXX_STANDARD 20)

file(GLOB_RECURSE TEST_SRC
        src/*.cpp
)

add_executable(151_Minciunescu_VladAndrei
        main.cpp
        ${TEST_SRC}
        include/Produs.h
        include/Bautura.h
        include/Desert.h
        include/Burger.h
        src/Desert.cpp
        src/Burger.cpp
        src/Bautura.cpp
        include/Angajat.h
        include/Casier.h
        src/Casier.cpp
        include/Livrator.h
        src/Livrator.cpp
        include/Bucatar.h
        src/Bucatar.cpp
        QV.h
        Comanda.h
        QV.cpp
        Comanda.cpp
)

target_include_directories(151_Minciunescu_VladAndrei PUBLIC include)
