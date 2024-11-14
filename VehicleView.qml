import QtQuick
import QtQuick.Controls 2
import QtQuick.Effects

Item {

    Rectangle {
	width: parent.width
	height: parent.height
	color: "#F0F0F0"

	Rectangle {
	    id: backButton
	    width: 50
	    height: 50
	    //anchors.top: parent.top
	    color: "transparent"
	    anchors.left: parent.left
	    anchors.verticalCenter: pageTitleRect.verticalCenter

	    Image {
		anchors.fill: parent
		source: "qrc:/assets/left-arrow.png"
	    }

	    MouseArea {
		anchors.fill: parent
		onClicked: {
		    goBack();
		}
		cursorShape: "PointingHandCursor"
	    }
	}

	Rectangle {
	    id: pageTitleRect
	    anchors.top: parent.top
	    //anchors.left: backButton.right
	    anchors.topMargin: 10
	    anchors.leftMargin: 10
	    anchors.horizontalCenter: parent.horizontalCenter
	    width: vehicleInfoLabel.width + imageRect.width + 30
	    height: 100
	    color: "#FFD54F"
	    //border.color: "black"
	    radius: 15
	    Rectangle {
		id: imageRect
		color: "transparent"
		width: 80
		height: 80
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.leftMargin: 10
		anchors.topMargin: 10

		Image {
		    anchors.fill: parent
		    source: "qrc:/assets/carIcon.png"
		}
	    }

	    Label {
		id: vehicleInfoLabel
		color: "#212121"
		font.pixelSize: 35
		text: "Vehicle Page"
		anchors.left: imageRect.right
		anchors.leftMargin: 10
		anchors.verticalCenter: imageRect.verticalCenter
	    }
	}

	Rectangle {
	    id: vehicleInfoRect
	    //color: "#fceac5"
	    anchors.left: parent.left
	    anchors.right: pageTitleRect.left
	    anchors.top: pageTitleRect.bottom
	    anchors.bottom: parent.bottom
	    radius: 30
	    anchors.leftMargin: 30
	    anchors.topMargin: 45
	    anchors.bottomMargin: 30
	    anchors.rightMargin: 20

	    gradient: Gradient {
		GradientStop {
		    position: 0.0
		    color: "#FFE6A3"
		}
		// GradientStop {
		//     position: 0.5
		//     color: "#fceac5"
		// }
		GradientStop {
		    position: 1.0
		    color: "#FFCE83"
		}
	    }

	    Column {
		id: infoColumn
		spacing: 10
		anchors.fill: parent
		anchors.margins: 20

		Label {
		    text: "Vehicle Information"
		    font.pixelSize: 24
		    color: "#333333"
		    font.bold: true
		    horizontalAlignment: Text.AlignHCenter
		    anchors.horizontalCenter: parent.horizontalCenter
		}

		Rectangle {
		    width: parent.width
		    height: 1
		    color: "#cccccc"
		}

		Row {
		    spacing: 10
		    width: parent.width
		    //width: parent.width
		    Label {
			id: modelLabel
			text: "Model:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getModel()
			font.pixelSize: 21
			color: "#333333"
			wrapMode: "Wrap"
			width: parent.width - modelLabel.width
		    }
		}

		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: markLabel
			text: "Mark:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getMark()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - markLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: yearLabel
			text: "Year:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getYear()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - yearLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: versionLabel
			text: "Version:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getVersion()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - versionLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: engineLabel
			text: "Engine:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getEngine()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - engineLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: typeLabel
			text: "Type:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getTypeString()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - typeLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: vinLabel
			text: "VIN:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getVin()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - vinLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    spacing: 10
		    width: parent.width
		    Label {
			id: registrationLabel
			text: "Registration:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getRegistrationNumber()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - registrationLabel.width
			wrapMode: "Wrap"
		    }
		}

		Rectangle {
		    width: parent.width
		    height: 1
		    color: "#cccccc"
		    anchors.topMargin: 10
		}
	    }
	}

	MultiEffect {
	    source: vehicleInfoRect
	    anchors.fill: vehicleInfoRect
	    shadowBlur: 1.0
	    shadowEnabled: true
	    shadowColor: "black"
	    shadowVerticalOffset: 0
	    shadowHorizontalOffset: 0
	}

	MultiEffect {
	    source: pageTitleRect
	    anchors.fill: pageTitleRect
	    shadowBlur: 1.0
	    shadowEnabled: true
	    shadowColor: "black"
	    shadowVerticalOffset: 0
	    shadowHorizontalOffset: 0
	}

	Rectangle {
	    id: tableViewRect
	    anchors.right: parent.right
	    anchors.top: pageTitleRect.bottom
	    anchors.left: vehicleInfoRect.right
	    anchors.bottom: parent.bottom
	    anchors.topMargin: 45
	    anchors.leftMargin: 30
	    anchors.rightMargin: 20
	    anchors.bottomMargin: 30
	    radius: 30
	    clip: true

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
			wrapMode: "Wrap"
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

		model: customer.getVehicles().getVehicleById(selectedVehicleId).getServices()

		columnWidthProvider: function (column) {
		    let width = explicitColumnWidth(column);
		    switch (column) {
		    // case 0:
		    //     return 50;
		    // case 1:
		    //     if (width >= 80) {
		    // 	return 80;
		    //     } else if (width <= 50)
		    // 	return 50;
		    //     else
		    // 	return explicitColumnWidth(column);
		    // case 2:
		    //     if (width <= 120) {
		    // 	return 120;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 3:
		    //     if (width <= 120) {
		    // 	return 120;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 4:
		    //     if (width <= 80) {
		    // 	return 80;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 5:
		    //     if (width <= 120) {
		    // 	return 120;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 6:
		    //     if (width <= 120) {
		    // 	return 120;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 7:
		    //     if (width <= 120) {
		    // 	return 120;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 8:
		    //     if (width <= 135) {
		    // 	return 135;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 9:
		    //     if (width <= 95) {
		    // 	return 95;
		    //     } else
		    // 	return explicitColumnWidth(column);
		    // case 13:
		    //     return 80;
		    default:
			return 130;
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
				return checkBoxServiceDelegate;
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
					return mileage;
				    case 2:
					return type;
				    case 3:
					return serviceDate;
				    case 4:
					return intervalKm;
				    case 5:
					return intervalTime;
				    case 6:
					return service;
				    case 8:
					return oil;
				    case 9:
					return oilFilter;
				    case 10:
					return airFilter;
				    case 11:
					return cabinFilter;
				    case 12:
					return timing;
				    case 13:
					return customParts;
				    default:
					return "";
				    }
				}
			    }
			}
		    }

		    Component {
			id: checkBoxServiceDelegate
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
				checked: selectedService

				onCheckedChanged: {
				    customer.getVehicles().getVehicleByRow(selectedVehicleId).getServices().toggleSelection(index);
				    customer.getVehicles().getVehicleByRow(selectedVehicleId).getServices().getSelectedServices();
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

			    // Row {
			    //     anchors.horizontalCenter: parent.horizontalCenter
			    //     anchors.verticalCenter: parent.verticalCenter
			    //     spacing: 4

			    //     Rectangle {
			    // 	id: showVehicleButton
			    // 	width: 30
			    // 	height: 30
			    // 	color: "white"
			    // 	radius: 5
			    // 	border.color: "black"
			    // 	scale: 1.0
			    // 	Image {
			    // 	    anchors.centerIn: parent
			    // 	    width: parent.width - 4
			    // 	    height: parent.height - 4
			    // 	    source: "qrc:/assets/magnifier.png"
			    // 	    fillMode: Image.PreserveAspectFit
			    // 	}
			    // 	MouseArea {
			    // 	    anchors.fill: parent
			    // 	    hoverEnabled: true
			    // 	    onEntered: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	    onExited: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onPressed: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onReleased: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	}
			    //     }

			    //     Rectangle {
			    // 	id: addServiceButton
			    // 	width: 30
			    // 	height: 30
			    // 	color: "white"
			    // 	radius: 5
			    // 	border.color: "black"
			    // 	scale: 1.0
			    // 	Image {
			    // 	    anchors.centerIn: parent
			    // 	    width: parent.width - 4
			    // 	    height: parent.height - 4
			    // 	    source: "qrc:/assets/addService2.png"
			    // 	    fillMode: Image.PreserveAspectFit
			    // 	}
			    // 	MouseArea {
			    // 	    anchors.fill: parent
			    // 	    hoverEnabled: true
			    // 	    onEntered: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	    onExited: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onPressed: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onReleased: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	}
			    //     }

			    //     Rectangle {
			    // 	id: editVehicleButton
			    // 	width: 30
			    // 	height: 30
			    // 	color: "white"
			    // 	radius: 5
			    // 	border.color: "black"
			    // 	scale: 1.0
			    // 	Image {
			    // 	    anchors.centerIn: parent
			    // 	    width: parent.width - 4
			    // 	    height: parent.height - 4
			    // 	    source: "qrc:/assets/edit2.png"
			    // 	    fillMode: Image.PreserveAspectFit
			    // 	}
			    // 	MouseArea {
			    // 	    anchors.fill: parent
			    // 	    hoverEnabled: true
			    // 	    onEntered: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	    onExited: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onPressed: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onReleased: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	}
			    //     }
			    //     Rectangle {
			    // 	id: removeVehicleButton
			    // 	width: 30
			    // 	height: 30
			    // 	color: "white"
			    // 	radius: 5
			    // 	border.color: "black"
			    // 	scale: 1.0
			    // 	Image {
			    // 	    anchors.centerIn: parent
			    // 	    width: parent.width - 4
			    // 	    height: parent.height - 4
			    // 	    source: "qrc:/assets/delete.png"
			    // 	    fillMode: Image.PreserveAspectFit
			    // 	}

			    // 	MouseArea {
			    // 	    anchors.fill: parent
			    // 	    hoverEnabled: true
			    // 	    onEntered: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	    onExited: {
			    // 		parent.scale = 1.0;
			    // 	    }

			    // 	    onPressed: {
			    // 		parent.scale = 1.0;
			    // 	    }
			    // 	    onReleased: {
			    // 		parent.scale = 1.07;
			    // 	    }
			    // 	}
			    //     }
			    //}
			}
		    }
		}
		ScrollBar.horizontal: ScrollBar {
		    policy: ScrollBar.AlwaysOn
		    anchors.bottom: parent.bottom
		}
	    }
	}
	MultiEffect {
	    source: tableViewRect
	    anchors.fill: tableViewRect
	    shadowBlur: 1.0
	    shadowEnabled: true
	    shadowColor: "black"
	    shadowVerticalOffset: 0
	    shadowHorizontalOffset: 0
	}
    }
}
