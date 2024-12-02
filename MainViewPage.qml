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
	width: 100
	height: 20
	color: "black"
	radius: 30
	anchors.top: parent.top
	anchors.right: parent.right
	anchors.topMargin: 5
	anchors.rightMargin: 30
	Row {
	    anchors.horizontalCenter: parent.horizontalCenter
	    anchors.verticalCenter: parent.verticalCenter
	    spacing: 5

	    Text {
		anchors.verticalCenter: parent.verticalCenter
		// anchors.horizontalCenter: parent.horizontalCenter
		color: "white"
		font.pixelSize: 15
		text: "Logout"
	    }
	}

	MouseArea {
	    anchors.fill: parent
	    onClicked: {}
	}
    }

    Rectangle {
	id: tableViewContainer
	anchors.bottom: logoId.top
	anchors.left: parent.left
	anchors.leftMargin: 10
	anchors.top: parent.top
	anchors.topMargin: 30
	anchors.right: parent.right
	anchors.rightMargin: 250
	color: "white"
	border.color: "black"
	clip: true

	HorizontalHeaderView {
	    id: horizontalHeader
	    anchors.left: tableView.left
	    anchors.top: parent.top
	    //anchors.topMargin: 1
	    syncView: tableView
	    clip: true
	    resizableColumns: true

	    delegate: Rectangle {
		color: "#2B2B2B"
		//height: 30
		//width: tableView.width / 5
		implicitHeight: 40
		border.color: "black"
		Text {
		    text: display
		    anchors.centerIn: parent
		    color: "#FFFFFF"
		    font.bold: true
		}
	    }
	}

	TableView {
	    id: tableView
	    anchors.top: horizontalHeader.bottom
	    anchors.left: parent.left
	    anchors.bottom: parent.bottom
	    anchors.bottomMargin: 1
	    //width: 1180
	    anchors.right: parent.right
	    anchors.margins: 1
	    clip: true
	    columnSpacing: 1
	    rowSpacing: 1
	    model: customer.getVehicles()

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
		    if (width <= 70) {
			return 70;
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
		    if (width <= 155) {
			return 155;
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
		color: selected ? "#f7daf2" : (row % 2 === 0 ? "#FFFFFF" : "#f5f2ed")//"white"
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
			//width: parent.width
			//height: parent.height
			color: selected ? "#f7daf2" : (row % 2 === 0 ? "#FFFFFF" : "#f5f2ed")//"lightgray"
			border.color: "#CCCCCC"
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
			//width: parent.width
			//height: parent.height
			color: selected ? "#f7daf2" : (row % 2 === 0 ? "#FFFFFF" : "#f5f2ed")//"lightgray"
			border.color: "#CCCCCC"

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
			//width: parent.width
			//height: parent.height
			color: selected ? "#f7daf2" : (row % 2 === 0 ? "#FFFFFF" : "#f5f2ed")//"lightgray"
			border.color: "#CCCCCC"
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
				    id: showVehicleMouseArea
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
				ToolTip {
				    visible: showVehicleMouseArea.containsMouse
				    delay: 500
				    text: "show"
				    x: showVehicleMouseArea.x
				    y: showVehicleMouseArea.y + 30
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
				    id: addServiceMouseArea
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

				ToolTip {
				    visible: addServiceMouseArea.containsMouse
				    delay: 500
				    text: "add service"
				    x: addServiceMouseArea.x
				    y: addServiceMouseArea.y + 30
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
				    id: editMouseArea
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

				ToolTip {
				    visible: editMouseArea.containsMouse
				    delay: 500
				    text: "edit"
				    x: editMouseArea.x
				    y: editMouseArea.y + 30
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
				    id: removeMouseArea
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
					removeVehicleDialog.openDialog(false);
				    }
				}
				ToolTip {
				    visible: removeMouseArea.containsMouse
				    delay: 500
				    text: "remove"
				    x: removeMouseArea.x
				    y: removeMouseArea.y + 30
				}
			    }
			}
		    }
		}
	    }

	    ScrollBar.horizontal: ScrollBar {
		policy: ScrollBar.AsNeeded
		anchors.bottom: parent.bottom
		//clip: true
	    }

	    ScrollBar.vertical: ScrollBar {
		policy: ScrollBar.AsNeeded
		//anchors.left: parent.right
		clip: true
	    }
	}
    }
    Rectangle {
	id: listviewRect
	anchors.left: tableViewContainer.right
	anchors.leftMargin: 10
	anchors.rightMargin: 10
	anchors.top: tableViewContainer.top
	anchors.right: parent.right
	anchors.bottom: tableViewContainer.bottom
	border.color: "black"
	radius: 10

	ListView {
	    id: notificationsList
	    model: notifModel
	    width: parent.width
	    height: parent.height
	    anchors.top: parent.top
	    anchors.left: parent.left

	    delegate: Rectangle {
		width: parent.width
		height: contentColumn.implicitHeight + 10  // Zmieniamy wysokość na wysokość contentColumn
		color: model.backgroundColor
		border.color: "black"
		radius: 10

		//anchors.centerIn: parent

		MouseArea {
		    anchors.fill: parent
		    onClicked: {
			console.log("Color: " + model.backgroundColor, "Elements: " + notifModel.rowCount());
		    }
		}

		Column {
		    id: contentColumn
		    anchors.top: parent.top
		    anchors.right: parent.right
		    anchors.left: parent.left
		    anchors.margins: 5
		    spacing: 2

		    Text {
			id: titleText
			anchors.horizontalCenter: parent.horizontalCenter
			color: "#2e2e2e"
			width: parent.width
			font.pixelSize: 17
			font.bold: true
			font.family: "Roboto Bold"
			wrapMode: "Wrap"
			//height: 40
			horizontalAlignment: Text.AlignHCenter
			text: model.serviceType + " REMINDER"
		    }

		    Row {
			id: rowNotificationServiceLabel
			spacing: 5
			//height: 40
			width: parent.width
			Label {
			    id: notificationServiceLabel
			    color: "black"
			    font.bold: true
			    font.pixelSize: 15
			    font.family: "Roboto Medium"
			    text: "Service:"
			    anchors.leftMargin: 5
			}

			Text {
			    color: "black"
			    font.pixelSize: 15
			    font.family: "Roboto Regular"
			    wrapMode: "Wrap"
			    width: parent.width - notificationServiceLabel.width
			    text: model.service
			}
		    }

		    Row {
			id: rowNotificationServiceDateLabel
			spacing: 5
			//height: 40
			width: parent.width
			Label {
			    id: notificationServiceDateLabel
			    color: "black"
			    font.bold: true
			    font.pixelSize: 15
			    font.family: "Roboto Medium"
			    text: "Service date:"
			}

			Text {
			    color: "black"
			    font.pixelSize: 15
			    font.family: "Roboto Regular"
			    wrapMode: "Wrap"
			    width: parent.width - notificationServiceDateLabel.width
			    text: model.serviceDate
			}
		    }

		    Row {
			id: rowNotificationVehicleRegistrationLabel
			spacing: 5
			//height: 40
			width: parent.width
			Label {
			    id: notificationVehicleRegistrationLabel
			    color: "black"
			    font.bold: true
			    font.pixelSize: 15
			    font.family: "Roboto Medium"
			    text: "Vehicle:"
			}

			Text {
			    color: "black"
			    font.pixelSize: 15
			    font.family: "Roboto Regular"
			    wrapMode: "Wrap"
			    width: parent.width - notificationVehicleRegistrationLabel.width
			    text: model.vehicleRegistration
			}
		    }

		    Row {
			id: rowNotificationNextServiceDateLabel
			spacing: 5
			//height: 40
			width: parent.width
			Label {
			    id: notificationNextServiceDateLabel
			    color: "black"
			    font.bold: true
			    font.pixelSize: 15
			    font.family: "Roboto Medium"
			    text: "Next service date:"
			}

			Text {
			    color: "black"
			    font.pixelSize: 15
			    font.family: "Roboto Regular"
			    wrapMode: "Wrap"
			    width: parent.width - notificationNextServiceDateLabel.width
			    text: model.nextServiceDate
			}
		    }

		    Row {
			id: rowNotificationMileageLabel
			spacing: 5
			//height: 40
			width: parent.width
			Label {
			    id: notificationMileageLabel
			    color: "black"
			    font.bold: true
			    font.pixelSize: 15
			    font.family: "Roboto Medium"
			    text: "Next service at:"
			}

			Text {
			    color: "black"
			    font.pixelSize: 15
			    font.family: "Roboto Regular"
			    wrapMode: "Wrap"
			    width: parent.width - notificationMileageLabel.width
			    text: model.nextServiceKm + "km"
			}
		    }

		    Row {
			id: rowNotificationDaysLeftLabel
			spacing: 5
			width: parent.width
			//height: 40
			Label {
			    id: notificationDaysLeftLabel
			    color: "black"
			    font.bold: true
			    font.pixelSize: 15
			    font.family: "Roboto Medium"
			    text: "Days left:"
			}

			Text {
			    color: "black"
			    font.pixelSize: 15
			    font.family: "Roboto Regular"
			    wrapMode: "Wrap"
			    width: parent.width - notificationDaysLeftLabel.width
			    text: model.daysLeft
			}
		    }

		    Rectangle {
			id: notificationButtonRect
			width: 80
			height: 25
			color: "white"
			radius: 5
			border.color: "black"
			scale: 1.0
			anchors.horizontalCenter: parent.horizontalCenter

			Text {
			    anchors.centerIn: parent
			    text: "Service done"
			    font.pixelSize: 12
			    font.family: "Roboto Regular"
			}

			MouseArea {
			    anchors.fill: parent
			    hoverEnabled: true

			    onClicked: {
				console.log("Elements: " + notifModel.rowCount());
			    }

			    onEntered: {
				notificationButtonRect.scale = 0.92;
			    }
			    onExited: {
				notificationButtonRect.scale = 1.0;
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

    RemoveVehicleDialog {
	id: removeVehicleDialog
    }

    Column {
	spacing: 5
	anchors.top: tableViewContainer.bottom
	anchors.topMargin: 10
	anchors.horizontalCenter: parent.horizontalCenter
	Row {
	    id: buttonsFirstRow
	    spacing: 5
	    // anchors.top: tableViewContainer.bottom
	    // anchors.topMargin: 10
	    // anchors.horizontalCenter: tableViewContainer.horizontalCenter
	    Rectangle {
		width: 200
		height: 40
		color: "black"

		radius: 30
		Row {
		    anchors.horizontalCenter: parent.horizontalCenter
		    anchors.verticalCenter: parent.verticalCenter
		    spacing: 5
		    Image {
			width: 30
			height: parent.height - 4
			source: "qrc:/assets/plus.png"
			fillMode: Image.PreserveAspectFit
			anchors.verticalCenter: parent.verticalCenter
			// anchors.horizontalCenter: parent.horizontalCenter
		    }

		    Text {
			anchors.verticalCenter: parent.verticalCenter
			// anchors.horizontalCenter: parent.horizontalCenter
			color: "white"
			font.pixelSize: 20
			text: "Add Vehicle"
		    }
		}

		MouseArea {
		    anchors.fill: parent
		    onClicked: {
			addVehicleDialog.openDialog();
		    }
		}
	    }

	    Rectangle {
		width: 220
		height: 40
		color: "black"
		radius: 30
		Row {
		    anchors.horizontalCenter: parent.horizontalCenter
		    anchors.verticalCenter: parent.verticalCenter
		    spacing: 5
		    Image {
			width: 30
			height: parent.height - 4
			source: "qrc:/assets/delete.png"
			fillMode: Image.PreserveAspectFit
			anchors.verticalCenter: parent.verticalCenter
			// anchors.horizontalCenter: parent.horizontalCenter
		    }

		    Text {
			anchors.verticalCenter: parent.verticalCenter
			// anchors.horizontalCenter: parent.horizontalCenter
			color: "white"
			font.pixelSize: 20
			text: "Remove checked"
		    }
		}

		MouseArea {
		    anchors.fill: parent
		    onClicked: {
			removeVehicleDialog.openDialog(true);
		    }
		}
	    }
	}

	Rectangle {
	    width: 220
	    height: 40
	    color: "black"
	    radius: 30
	    anchors.horizontalCenter: parent.horizontalCenter
	    Row {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		spacing: 5
		Image {
		    width: 30
		    height: parent.height - 4
		    source: "qrc:/assets/export.png"
		    fillMode: Image.PreserveAspectFit
		    anchors.verticalCenter: parent.verticalCenter
		    // anchors.horizontalCenter: parent.horizontalCenter
		}

		Text {
		    anchors.verticalCenter: parent.verticalCenter
		    // anchors.horizontalCenter: parent.horizontalCenter
		    color: "white"
		    font.pixelSize: 20
		    text: "Export data"
		}
	    }

	    MouseArea {
		anchors.fill: parent
		onClicked: {}
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
