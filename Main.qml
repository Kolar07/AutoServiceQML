import QtQuick
import QtQuick.Controls 2

ApplicationWindow {
    id:main
    visible: true
    width: 1280
    height: 720

 //    signal showVehicle(int vehicleId)
 //    signal showService(int serviceId)

 //    onShowVehicle: {
	// selectedVehicleId = vehicleId;
	// viewLoader.source = "VehicleView.qml";
 //    }

 //    onShowService: {
	// selectedServiceId = serviceId;
	// viewLoader.source = "ServiceView.qml";
 //    }

 //    Loader {
	// id: viewLoader
	// anchors.fill: parent
	// source: "LoginPage.qml"
 //    }

	signal showLogin()
	signal showRegister()
	signal showMainView()
	signal showVehicle(int vehicleId)
	signal showService(int vehicleId, int serviceId)

	//property int selectedVehicleId: -1
	//property int selectedServiceId: -1

	Loader {
	    id: mainLoader
	    anchors.fill: parent
	    source: "LoginPage.qml" // Startujemy z login page
	}

	// Obsługa sygnałów do zmiany głównego widoku
	onShowLogin: mainLoader.source = "LoginPage.qml"
	onShowRegister: mainLoader.source = "RegistrationPage.qml"
	onShowMainView: mainLoader.source = "MainViewPage.qml"
}
