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

	// onLoaded: {
	//     if (mainLoader.item && mainLoader.item.setVehicleData) {
	// 	mainLoader.item.setVehicleData(mainLoader.vehicleId, mainLoader.serviceId);
	//     }
	// }
    }

    function loadLoginPage() {
	mainLoader.source = "LoginPage.qml";
    }

    function loadRegisterPage() {
	mainLoader.source = "RegistrationPage.qml";
    }

    function loadMainViewPage() {
	mainLoader.source = "MainViewPage.qml";
    }

    function loadVehiclePage(vehicleId) {
	mainLoader.source = "VehicleView.qml";
	mainLoader.item.selectedVehicleId = vehicleId;
    }
    function loadBackVehiclePage(vehicleId, serviceId) {
	mainLoader.source = "VehicleView.qml";
	mainLoader.item.selectedVehicleId = vehicleId;
	mainLoader.item.selectedServiceId = serviceId;
    }

    function loadServicePage(vehicleId, serviceId) {
	mainLoader.source = "ServiceView.qml";
	mainLoader.item.selectedVehicleId = vehicleId;
	mainLoader.item.selectedServiceId = serviceId;
    }

    onShowLogin: loadLoginPage()
    onShowRegister: loadRegisterPage()
    onShowMainView: loadMainViewPage()
    onShowVehicle: vehicleId => loadVehiclePage(vehicleId)
    onShowBackVehicle: (vehicleId, serviceId) => loadBackVehiclePage(vehicleId, serviceId)
    onShowService: (vehicleId, serviceId) => loadServicePage(vehicleId, serviceId)
}
