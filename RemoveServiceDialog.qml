import QtQuick
import QtQuick.Controls

Item {
    function openDialog() {
	removeServiceDialog.open();
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
			if (dbController.removeService(selectedServiceId)) {
			    customer.fetchServicesVersionSpecifiedVehicle(selectedVehicleId); //MAKE A METHOD WHICH FETCHES SERVICES FOR SPECIFIED VEHICLE
			    removeServiceDialog.close();	     //TO PREVENT SERVICES FROM DISAPPEARING
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
