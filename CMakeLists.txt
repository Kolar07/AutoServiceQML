cmake_minimum_required(VERSION 3.16)

project(AutoServiceQML VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Znalezienie Qt
find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql QuickControls2)

qt_standard_project_setup(REQUIRES 6.5)

# Dodanie wykonawczego pliku
qt_add_executable(appAutoServiceQML
    main.cpp
)

# Dodanie modułu QML
qt_add_qml_module(appAutoServiceQML
    URI AutoServiceQML
    VERSION 1.0
    QML_FILES
    Main.qml
    QML_FILES NotificationQML.qml
    SOURCES customer.h customer.cpp
    SOURCES registercontroller.h registercontroller.cpp
    SOURCES vehicle.h vehicle.cpp
    SOURCES databasecontroller.h databasecontroller.cpp
    QML_FILES RegistrationPage.qml
    SOURCES logincontroller.h logincontroller.cpp
    QML_FILES LoginPage.qml
    SOURCES sessioncontroller.h sessioncontroller.cpp
    QML_FILES MainViewPage.qml
    RESOURCES resource.qrc
    SOURCES service.h service.cpp
    SOURCES vehicletype.h vehicletype.cpp
    SOURCES notification.h notification.cpp
    SOURCES maintenanceservice.h maintenanceservice.cpp
    SOURCES repairservice.h repairservice.cpp
    SOURCES serviceoil.h serviceoil.cpp
    SOURCES servicetiming.h servicetiming.cpp
    SOURCES vehicletypecontainer.h vehicletypecontainer.cpp
)

# Ustawienia właściwości celu
set_target_properties(appAutoServiceQML PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Linkowanie z Qt
target_link_libraries(appAutoServiceQML
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Sql
)

# Instalacja
include(GNUInstallDirs)
install(TARGETS appAutoServiceQML
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
