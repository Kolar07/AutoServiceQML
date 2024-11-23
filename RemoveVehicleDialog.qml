import QtQuick
import QtQuick.Controls

Item {

    property bool removeMultiple: false
    function openDialog(choice) {
	removeVehicleDialog.open();
	removeMultiple = choice;
    }

    Dialog {
	id: removeVehicleDialog
	anchors.centerIn: parent
	width: 300
	height: 150
	parent: Overlay.overlay
	focus: true
	modal: true
	title: ""
	Column {
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter
	    Label {
		text: "This CAN NOT be undone!"
		font.pixelSize: 20
		color: "black"
		font.bold: true
	    }
	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter
		Button {
		    text: "Remove"
		    onClicked: {
			if(!removeMultiple) {

			if (dbController.removeVehicle(selectedVehicleId)) {
			    customer.fetchVehicles(customer.getId());
			    removeVehicleDialog.close();
			} else removeVehicleDialog.close();
			} else {
			    if (dbController.removeMultipleVehicles(customer.getVehicles().getVehiclesIds())) {
				customer.fetchVehicles(customer.getId());
				removeVehicleDialog.close();
			    } else removeVehicleDialog.close();
			}
		    }
		}
		Button {
		    text: "Cancel"
		    onClicked: {
			removeVehicleDialog.close();
		    }
		}
	    }
	}
    }
}
