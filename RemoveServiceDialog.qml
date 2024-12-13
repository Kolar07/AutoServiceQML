import QtQuick
import QtQuick.Controls

Item {
    property bool removeMultiple: false
    function openDialog(choice) {
	removeServiceDialog.open();
	removeMultiple = choice;
    }

    Dialog {
	id: removeServiceDialog
	anchors.centerIn: parent
	width: 300
	height: 120
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
			if (!removeMultiple) {
			    if (dbController.removeService(selectedServiceId)) {
				customer.fetchServicesVersionSpecifiedVehicle(selectedVehicleId);
				notifModel.fetchNotifications(customer.getId());
				removeServiceDialog.close();
			    } else
				removeServiceDialog.close();
			} else {
			    if (dbController.removeMultipleServices(customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getSelectedServicesIds())) {
				customer.fetchServicesVersionSpecifiedVehicle(selectedVehicleId);
				notifModel.fetchNotifications(customer.getId());
				removeServiceDialog.close();
			    } else
				removeServiceDialog.close();
			}
		    }
		}
		Button {
		    text: "Cancel"
		    onClicked: {
			removeServiceDialog.close();
		    }
		}
	    }
	}
    }
}
