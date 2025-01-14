cmake_minimum_required(VERSION 3.16)

project(AutoServiceQML VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql QuickControls2 PrintSupport)



qt_standard_project_setup(REQUIRES 6.5)


qt_add_executable(appAutoServiceQML
    main.cpp
)



qt_add_qml_module(appAutoServiceQML
    URI AutoServiceQML
    VERSION 1.0
    QML_FILES
    Main.qml
    QML_FILES
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
    SOURCES
    SOURCES vehiclemodel.h vehiclemodel.cpp
    SOURCES servicemodel.h servicemodel.cpp
    QML_FILES VehicleView.qml
    SOURCES validationcontroller.h validationcontroller.cpp
    QML_FILES AddServiceDialog.qml
    QML_FILES AddVehicleDialog.qml
    QML_FILES EditVehicleDialog.qml
    QML_FILES EditServiceDialog.qml
    QML_FILES RemoveServiceDialog.qml
    QML_FILES ServiceView.qml
    QML_FILES RemoveVehicleDialog.qml
    SOURCES notificationmodel.h notificationmodel.cpp
    QML_FILES WarningNotificationDialog.qml
    SOURCES
    SOURCES reportsgenerator.h reportsgenerator.cpp
    QML_FILES ChoosePathDialog.qml
    QML_FILES LogoutDialog.qml
    QML_FILES ChangePasswordDialog.qml
    QML_FILES SuccessDialog.qml
)


set_target_properties(appAutoServiceQML PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAutoServiceQML
    PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Sql Qt6::PrintSupport
)


include(GNUInstallDirs)
install(TARGETS appAutoServiceQML
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
