import QtQuick
import QtQuick.Controls 2

ApplicationWindow {
    visible: true
    width: 1280
    height: 720

    signal showVehicle(int vehicleId)

    onShowVehicle: {
	selectedVehicleId = vehicleId;
	viewLoader.source = "VehicleView.qml"
    }

    Loader { //change to stackview so mainview will not be destroyed
	id: viewLoader
	anchors.fill: parent
	source: "MainViewPage.qml"
    }
}
