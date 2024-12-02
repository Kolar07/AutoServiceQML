import QtQuick
import QtQuick.Controls

Item {
    function openDialog() {
	warningNotificationDialog.open();
    }

    Dialog {
	id: warningNotificationDialog
	anchors.centerIn: parent
	width: 300
	height: 160
	parent: Overlay.overlay
	focus: true
	modal: true
	title: ""
	Column {
	    spacing: 5
	    anchors.fill: parent
	    Label {
		text: "Notification for this service already exists or no interval given!"
		horizontalAlignment: "AlignHCenter"
		width: parent.width
		font.pixelSize: 20
		wrapMode: "Wrap"
		color: "black"
		font.bold: true
	    }

	    Button {
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Ok"
		onClicked: {
		    warningNotificationDialog.close();
		}
	    }
	}
    }
}
