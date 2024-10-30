import QtQuick
import QtQuick.Controls 2

Item {
    id: mainViewPage

    property int selectedVehicleId: -1
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
		    if (width <= 135) {
			return 135;
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
				    return mark;
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
					showVehicle(row);
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
				}
			    }
			}
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
		addVehicleDialog.open();
	    }
	}
    }

    Dialog {
	id: addVehicleDialog
	anchors.centerIn: parent
	width: 450
	height: 500
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Add vehicle"
	standardButtons: Dialog.Ok | Dialog.Cancel

	Column {
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter

	    TextField {
		id: markInput
		background: Rectangle {
		    id: markTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: markTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Mark...                      "
	    }

	    Label {
		id: wrongMarkInput
		visible: false
		text: "Mark should contain only letters!"
	    }

	    TextField {
		id: modelInput
		background: Rectangle {
		    id: modelTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: modelTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Model...                      "
	    }
	    Label {
		id: wrongModelInput
		visible: false
		text: "Model should not be empty"
	    }

	    TextField {
		id: yearInput
		background: Rectangle {
		    id: yearTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: yearTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Year...                      "
	    }

	    Label {
		id: wrongYearInput
		visible: false
		text: "Year should contain only digits!"
	    }

	    TextField {
		id: versionInput
		background: Rectangle {
		    id: versionTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: versionTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Version...                      "
	    }
	    Label {
		id: wrongVersionInput
		visible: false
		text: "Version should not be empty!"
	    }

	    TextField {
		id: engineInput
		background: Rectangle {
		    id: engineTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: engineTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Engine...                      "
	    }
	    Label {
		id: wrongEngineInput
		visible: false
		text: "Engine should not be empty!"
	    }

	    TextField {
		id: vinInput
		background: Rectangle {
		    id: vinTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: vinTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Year...                      "
	    }
	    Label {
		id: wrongVinInput
		visible: false
		text: "Year should contain 12 characters!"
	    }

	    TextField {
		id: registrationInput
		background: Rectangle {
		    id: registrationTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: registrationTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Registration number...                      "
	    }
	    Label {
		id: wrongRegistrationInput
		visible: false
		text: "Registration should not be empty!"
	    }
	}

	Loader {
	    id: viewLoader
	    anchors.fill: parent
	    source: ""
	}
    }

    function showVehicle(vehicleId) {
	selectedVehicleId = vehicleId;
	viewLoader.source = "VehicleView.qml";
    }

    function goBack() {
	viewLoader.source = "";
    }

    // ComboBox {
    //     model: vehicleTypeModel
    //     textRole: "typeName"  // Wyświetla nazwę typu pojazdu
    //     width: implicitWidth + 50
    //     onCurrentIndexChanged: {
    // 	console.log("Selected Vehicle Type:", vehicleTypeModel.get(currentIndex).typeName);
    //     }
    // }

}
