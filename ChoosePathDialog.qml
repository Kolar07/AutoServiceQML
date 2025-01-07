import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    function openDialog(choice) {
	choosePathDialog.open();
    }

    Dialog {
	id: choosePathDialog
	anchors.centerIn: parent
	width: 500
	height: 250
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Export data"
	Column {
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter
	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter
		Label {
		    id: pathLabel
		    text: "Choose file path"
		    font.pixelSize: 12
		    color: "black"
		    font.bold: true
		}

		Rectangle {
		    width: 50
		    height: 20
		    radius: 5
		    color: "black"
		    anchors.verticalCenter: pathLabel.verticalCenter
		    Text {
			text: "Open"
			font.pixelSize: 12
			anchors.centerIn: parent
			color: "white"
		    }
		    MouseArea {
			anchors.fill: parent
			onClicked: {
			    fileDialog.open();
			}
		    }
		}
	    }
	    Label {
		id: wrongFilePath
		text: "Provide file path"
		color: "red"
		font.pixelSize: 12
		anchors.horizontalCenter: parent.horizontalCenter
		visible: false
	    }
	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter
		TextField {
		    id: fileNameInput
		    height: 40
		    width: 100
		    font.pixelSize: 12
		    placeholderText: "file name"
		    validator: RegularExpressionValidator {
			regularExpression: /^[^<>:"/\\|?*\x00-\x1F]+$/
		    }
		}
		Label {
		    id: wrongFileNameInput
		    text: "Provide file name"
		    color: "red"
		    font.pixelSize: 12
		    anchors.verticalCenter: fileNameInput.verticalCenter
		    visible: false
		}
	    }

	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter

		Button {
		    text: "Export to CSV"
		    onClicked: {
			if (fileNameInput.text !== "") {
			    if (pathLabel.text !== "Choose file path") {
				reportsGenerator.generateVehiclesCSV(customer.getName(), customer.getSurname(), customer.getId(), customer.getVehicles().getVehicles(), fileDialog.selectedFolder, fileNameInput.text);
				reportsGenerator.generateServicesCSV(customer.getName(), customer.getSurname(), customer.getId(), customer.getVehicles().getVehicles(), fileDialog.selectedFolder, fileNameInput.text);
				fileNameInput.text = "";
				pathLabel.text = "Choose file path";
				choosePathDialog.close();
			    } else
				wrongFilePath.visible = true;
			} else
			    wrongFileNameInput.visible = true;
		    }
		}

		Button {
		    text: "Cancel"
		    onClicked: {
			fileNameInput.text = "";
			pathLabel.text = "Choose file path";
			choosePathDialog.close();
		    }
		}
	    }
	}
    }

    FolderDialog {
	id: fileDialog
	title: "Select Folder"
	onAccepted: {
	    pathLabel.text = fileDialog.selectedFolder;
	    console.log("File will be saved to: " + pathLabel.text);
	}
    }
}
