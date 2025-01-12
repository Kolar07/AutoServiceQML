import QtQuick
import QtQuick.Controls 2

ApplicationWindow {
    id: main
    visible: true
    width: 1350
    height: 720

    signal showLogin
    signal showRegister
    signal showMainView
    signal showVehicle(int vehicleId)
    signal showBackVehicle(int vehicleId, int serviceId)
    signal showService(int vehicleId, int serviceId)

    Loader {
	id: mainLoader
	anchors.fill: parent
	source: "LoginPage.qml"
    }

    onShowLogin: mainLoader.source = "LoginPage.qml"
    onShowRegister: mainLoader.source = "RegistrationPage.qml"
    onShowMainView: mainLoader.source = "MainViewPage.qml"
    onShowVehicle: {
	mainLoader.source = "VehicleView.qml";
	mainLoader.item.selectedVehicleId = vehicleId;
    }
    onShowBackVehicle: {
	mainLoader.source = "VehicleView.qml";
	mainLoader.item.selectedVehicleId = vehicleId;
	mainLoader.item.selectedServiceId = serviceId;
    }
    onShowService: {
	mainLoader.source = "ServiceView.qml";
	mainLoader.item.selectedVehicleId = vehicleId;
	mainLoader.item.selectedServiceId = serviceId;
    }
}
