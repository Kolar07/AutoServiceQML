import QtQuick
import QtQuick.Controls

Item {
    function openDialog() {
	logoutDialog.open();
    }

    Dialog {
	id: logoutDialog
	anchors.centerIn: parent
	width: 250
	height: 120
	parent: Overlay.overlay
	focus: true
	modal: true
	Column {
	    spacing: 5
	    anchors.fill: parent
	    Label {
		text: "Are you sure?"
		horizontalAlignment: "AlignHCenter"
		width: parent.width
		font.pixelSize: 20
		wrapMode: "Wrap"
		color: "black"
		font.bold: true
	    }
	    Row {
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 5
		Button {
		    //anchors.horizontalCenter: parent.horizontalCenter
		    text: "Ok"
		    onClicked: {
			customer.print();
			main.onShowLogin();
		    }
		}

		Button {
		    //anchors.horizontalCenter: parent.horizontalCenter
		    text: "Cancel"
		    onClicked: {
			logoutDialog.close();
		    }
		}
	    }
	}
    }
}
