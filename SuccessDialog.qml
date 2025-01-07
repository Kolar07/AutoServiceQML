import QtQuick
import QtQuick.Controls

Item {
    function openDialog() {
	successDialog.open();
    }

    Dialog {
	id: successDialog
	anchors.centerIn: parent
	width: 300
	height: 160
	parent: Overlay.overlay
	focus: true
	modal: true
	Column {
	    spacing: 5
	    anchors.fill: parent
	    Label {
		text: "SUCCESS"
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
		    successDialog.close();
		}
	    }
	}
    }
}
