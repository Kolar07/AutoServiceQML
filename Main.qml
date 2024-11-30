import QtQuick
import QtQuick.Controls 2

ApplicationWindow {
    visible: true
    width: 1280
    height: 720

    signal showVehicle(int vehicleId)
    signal showService(int serviceId)

    onShowVehicle: {
	selectedVehicleId = vehicleId;
	viewLoader.source = "VehicleView.qml";
    }

    onShowService: {
	selectedServiceId = serviceId;
	viewLoader.source = "ServiceView.qml";
    }

    Loader { //change to stackview so mainview will not be destroyed
	id: viewLoader
	anchors.fill: parent
	source: "MainViewPage.qml"
    }
}
