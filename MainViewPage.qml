import QtQuick
import QtQuick.Controls 2

Item {
    id: mainViewPage

    property int selectedVehicleId: -1
    property int selectedServiceId: -1
    Image {
	id: logoId
	anchors.left: parent.left
	anchors.bottom: parent.bottom
	width: 180
	height: 100
	source: "qrc:/assets/logo.png"
    }

    Rectangle {
	id: tableViewContainer
	anchors.bottom: logoId.top
	anchors.left: parent.left
	anchors.leftMargin: 30
	anchors.top: parent.top
	anchors.topMargin: 30
	anchors.right: parent.right
	anchors.rightMargin: 30
	color: "white"
	border.color: "black"

	HorizontalHeaderView {
	    id: horizontalHeader
	    anchors.left: tableView.left
	    anchors.top: parent.top
	    syncView: tableView
	    clip: true
	    resizableColumns: true

	    delegate: Rectangle {
		color: "black"
		//height: 30
		//width: tableView.width / 5
		//border.color: "black"
		Text {
		    text: display
		    anchors.centerIn: parent
		    color: "white"
		    font.bold: true
		}
	    }
	}

	TableView {
	    id: tableView
	    anchors.top: horizontalHeader.bottom
	    //anchors.left: parent.left
	    //anchors.right: parent.right
	    anchors.bottom: parent.bottom
	    //anchors.margins: 20
	    anchors.horizontalCenter: parent.horizontalCenter
	    width: 1180
	    //width: 1250
	    clip: true
	    columnSpacing: 1
	    rowSpacing: 1

	    model: customer.getVehicles()

	    ScrollBar {
		orientation: Qt.Horizontal
		policy: ScrollBar.AlwaysOn
		anchors.bottom: parent.bottom
	    }

	    // Vertical ScrollBar for rows
	    ScrollBar {
		orientation: Qt.Vertical
		policy: ScrollBar.AlwaysOn
		anchors.right: parent.right
	    }

	    columnWidthProvider: function (column) {
		let width = explicitColumnWidth(column);
		switch (column) {
		case 0:
		    return 50;
		case 1:
		    if (width >= 80) {
			return 80;
		    } else if (width <= 50)
			return 50;
		    else
			return explicitColumnWidth(column);
		case 2:
		    if (width <= 120) {
			return 120;
		    } else
			return explicitColumnWidth(column);
		case 3:
		    if (width <= 120) {
			return 120;
		    } else
			return explicitColumnWidth(column);
		case 4:
		    if (width <= 80) {
			return 80;
		    } else
			return explicitColumnWidth(column);
		case 5:
		    if (width <= 120) {
			return 120;
		    } else
			return explicitColumnWidth(column);
		case 6:
		    if (width <= 120) {
			return 120;
		    } else
			return explicitColumnWidth(column);
		case 7:
		    if (width <= 120) {
			return 120;
		    } else
			return explicitColumnWidth(column);
		case 8:
		    if (width <= 145) {
			return 145;
		    } else
			return explicitColumnWidth(column);
		case 9:
		    if (width <= 95) {
			return 95;
		    } else
			return explicitColumnWidth(column);
		case 10:
		    return 150;
		default:
		    return 120;
		}
	    }

	    delegate: Rectangle {
		width: tableView.columnWidthProvider(column)
		height: 50
		color: "white"
		border.color: "#cccccc"

		Loader {
		    anchors.fill: parent

		    sourceComponent: {
			if (column === 0) {
			    return checkBoxDelegate;
			} else if (column === 10)
			    return actionFieldDelegate;
			else
			    return textDelegate;
		    }
		}

		Component {
		    id: textDelegate
		    Rectangle {
			width: parent.width
			height: parent.height
			color: "lightgray"

			Text {
			    anchors.fill: parent
			    font.pixelSize: 14
			    wrapMode: "Wrap"
			    verticalAlignment: Text.AlignVCenter
			    horizontalAlignment: Text.AlignHCenter
			    text: {
				switch (column) {
				case 1:
				    return id;
				case 7:
				    return type;
				case 2:
				    return brand;
				case 3:
				    return model;
				case 4:
				    return year;
				case 5:
				    return version;
				case 6:
				    return engine;
				case 8:
				    return vin;
				case 9:
				    return regNumber;
				default:
				    return "";
				}
			    }
			}
		    }
		}

		Component {
		    id: checkBoxDelegate
		    Rectangle {
			id: checkBoxRect
			width: parent.width
			height: parent.height
			color: "lightgray"

			// CheckBox {
			//     id: control
			//     checked: false

			//     anchors.centerIn: parent

			//     indicator: Rectangle {
			// 	implicitWidth: 26
			// 	implicitHeight: 26
			// 	radius: 3
			// 	border.color: control.down ? "black" : "black"
			// 	anchors.centerIn: parent

			// 	Rectangle {
			// 	    width: 14
			// 	    height: 14
			// 	    x: 6
			// 	    y: 6
			// 	    radius: 2
			// 	    color: control.down ? "black" : "black"
			// 	    visible: control.checked
			// 	}
			// 	onCheckedChanged: {}
			//     }

			//    contentItem: Text {
			// //text: control.text
			// font: control.font
			// opacity: enabled ? 1.0 : 0.3
			// color: control.down ? "#17a81a" : "#21be2b"
			// verticalAlignment: Text.AlignVCenter
			// leftPadding: control.indicator.width + control.spacing
			//    }
			//}

			CheckBox {
			    anchors.centerIn: parent
			    checked: selected

			    onCheckedChanged: {
				customer.getVehicles().toggleSelection(index);
				customer.getVehicles().getSelectedVehicles();
			    }
			}
		    }
		}

		Component {
		    id: actionFieldDelegate
		    Rectangle {
			width: parent.width
			height: parent.height
			color: "lightgray"

			Row {
			    anchors.horizontalCenter: parent.horizontalCenter
			    anchors.verticalCenter: parent.verticalCenter
			    spacing: 4

			    Rectangle {
				id: showVehicleButton
				width: 30
				height: 30
				color: "white"
				radius: 5
				border.color: "black"
				scale: 1.0
				Image {
				    anchors.centerIn: parent
				    width: parent.width - 4
				    height: parent.height - 4
				    source: "qrc:/assets/magnifier.png"
				    fillMode: Image.PreserveAspectFit
				}
				MouseArea {
				    anchors.fill: parent
				    hoverEnabled: true
				    onEntered: {
					parent.scale = 1.07;
				    }
				    onExited: {
					parent.scale = 1.0;
				    }
				    onPressed: {
					parent.scale = 1.0;
				    }
				    onReleased: {
					parent.scale = 1.07;
				    }
				    onClicked: {
					showVehicle(customer.getVehicles().getVehicleByRow(row).getId());
				    }
				}
			    }

			    Rectangle {
				id: addServiceButton
				width: 30
				height: 30
				color: "white"
				radius: 5
				border.color: "black"
				scale: 1.0
				Image {
				    anchors.centerIn: parent
				    width: parent.width - 4
				    height: parent.height - 4
				    source: "qrc:/assets/addService2.png"
				    fillMode: Image.PreserveAspectFit
				}
				MouseArea {
				    anchors.fill: parent
				    hoverEnabled: true
				    onEntered: {
					parent.scale = 1.07;
				    }
				    onExited: {
					parent.scale = 1.0;
				    }
				    onPressed: {
					parent.scale = 1.0;
				    }
				    onReleased: {
					parent.scale = 1.07;
				    }
				    onClicked: {
					setSelectedVehicle(customer.getVehicles().getVehicleByRow(row).getId());
					addServiceDialog.openDialog();
				    }
				}
			    }

			    Rectangle {
				id: editVehicleButton
				width: 30
				height: 30
				color: "white"
				radius: 5
				border.color: "black"
				scale: 1.0
				Image {
				    anchors.centerIn: parent
				    width: parent.width - 4
				    height: parent.height - 4
				    source: "qrc:/assets/edit2.png"
				    fillMode: Image.PreserveAspectFit
				}
				MouseArea {
				    anchors.fill: parent
				    hoverEnabled: true
				    onEntered: {
					parent.scale = 1.07;
				    }
				    onExited: {
					parent.scale = 1.0;
				    }
				    onPressed: {
					parent.scale = 1.0;
				    }
				    onReleased: {
					parent.scale = 1.07;
				    }
				    onClicked: {
					setSelectedVehicle(customer.getVehicles().getVehicleByRow(row).getId());
					editVehicleDialog.openDialog();
				    }
				}
			    }
			    Rectangle {
				id: removeVehicleButton
				width: 30
				height: 30
				color: "white"
				radius: 5
				border.color: "black"
				scale: 1.0
				Image {
				    anchors.centerIn: parent
				    width: parent.width - 4
				    height: parent.height - 4
				    source: "qrc:/assets/delete.png"
				    fillMode: Image.PreserveAspectFit
				}

				MouseArea {
				    anchors.fill: parent
				    hoverEnabled: true
				    onEntered: {
					parent.scale = 1.07;
				    }
				    onExited: {
					parent.scale = 1.0;
				    }

				    onPressed: {
					parent.scale = 1.0;
				    }
				    onReleased: {
					parent.scale = 1.07;
				    }
				    onClicked: {
					setSelectedVehicle(customer.getVehicles().getVehicleByRow(row).getId());
					removeVehicleDialog.open();
				    }
				}
			    }
			}
		    }
		}
	    }
	}
    }

    AddServiceDialog {
	id: addServiceDialog
    }

    EditVehicleDialog {
	id: editVehicleDialog
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
			if (dbController.removeVehicle(selectedVehicleId)) {
			    customer.fetchVehicles(customer.getId());
			    removeVehicleDialog.close();
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

    Rectangle {
	width: 200
	height: 40
	color: "black"
	anchors.top: tableViewContainer.bottom
	anchors.topMargin: 10
	anchors.horizontalCenter: tableViewContainer.horizontalCenter
	radius: 30
	Text {
	    anchors.centerIn: parent
	    color: "white"
	    font.pixelSize: 20
	    text: "Add Vehicle"
	}

	MouseArea {
	    anchors.fill: parent
	    onClicked: {
		addVehicleDialog.openDialog();
	    }
	}
    }
    AddVehicleDialog {
	id: addVehicleDialog
    }

    Dialog {
	id: newTypeDialog
	anchors.centerIn: parent
	width: 300
	height: 250
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "New Type"

	Column {
	    TextField {
		id: typeInput
		background: Rectangle {
		    id: typeTextRect
		    color: "white"
		    radius: 10
		    width: 200
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: typeTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Type...                      "
	    }
	    Label {
		id: wrongTypeInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Type duplicate or empty!"
	    }
	}

	Row {
	    spacing: 10
	    anchors.horizontalCenter: parent.horizontalCenter
	    anchors.bottom: parent.bottom
	    anchors.bottomMargin: 10
	    Button {
		text: "OK"
		onClicked: {
		    if (!vehicleTypeModel.findType(typeInput.text) && valid.typeIsValid(typeInput.text)) {
			if (dbController.addVehicleType(typeInput.text)) {
			    dbController.fetchVehicleTypes();
			    console.log("Type added");
			    newTypeDialog.close();
			}
		    } else
			wrongTypeInput.visible = true;
		}
	    }

	    Button {
		text: "Cancel"
		onClicked: newTypeDialog.close()
	    }
	}
    }

    Loader {
	id: viewLoader
	anchors.fill: parent
	source: ""
    }

    function showVehicle(vehicleId) {
	selectedVehicleId = vehicleId;
	viewLoader.source = "VehicleView.qml";
    }

    function setSelectedVehicle(vehicleId) {
	selectedVehicleId = vehicleId;
    }

    function goBack() {
	viewLoader.source = "";
    }
}
