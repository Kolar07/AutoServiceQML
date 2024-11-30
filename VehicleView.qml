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
	    anchors.topMargin: 30
	    anchors.bottomMargin: 60
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
			id: brandLabel
			text: "Brand:"
			font.pixelSize: 21
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getBrand()
			font.pixelSize: 21
			color: "#333333"
			width: parent.width - brandLabel.width
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
	    anchors.topMargin: 30
	    anchors.leftMargin: 30
	    anchors.rightMargin: 20
	    anchors.bottomMargin: 60
	    radius: 30
	    layer.enabled: true
	    clip: true

	    HorizontalHeaderView {
		id: horizontalHeader
		anchors.left: tableView.left
		anchors.top: parent.top
		anchors.topMargin: 10
		syncView: tableView
		clip: true
		resizableColumns: true

		delegate: Rectangle {
		    //color: "#FFB84D"
		    implicitHeight: 50
		    //height: 30
		    //width: tableView.width / 5
		    //border.color: "black"
		    Text {
			text: display
			//anchors.centerIn: parent
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			color: "#FFFFFF"
			font.bold: true
			font.pixelSize: 15
			wrapMode: "Wrap"
		    }
		    gradient: Gradient {
			GradientStop {
			    position: 0.0
			    color: "#FFB84D"
			}
			// GradientStop {
			//     position: 0.5
			//     color: "#fceac5"
			// }
			GradientStop {
			    position: 1.0
			    color: "#ed9a1c"
			}
		    }
		    clip: true
		}
	    }

	    TableView {
		id: tableView
		anchors.top: horizontalHeader.bottom
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.leftMargin: 10
		clip: true
		columnSpacing: 1
		rowSpacing: 1

		model: customer.getVehicles().getVehicleById(selectedVehicleId).getServices()

		columnWidthProvider: function (column) {
		    let width = explicitColumnWidth(column);
		    switch (column) {
		    case 0:
			return 60;
		    case 1:
			if (width >= 80) {
			    return 80;
			} else if (width <= 60)
			    return 60;
			else
			    return explicitColumnWidth(column);
		    case 2:
			if (width <= 140) {
			    return 140;
			} else
			    return explicitColumnWidth(column);
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
		    color: row % 2 === 0 ? "#FFF8E7" : "#FFE6CC"
		    border.color: "#FAF2D0"
		    clip: true

		    Loader {
			anchors.fill: parent

			sourceComponent: {
			    if (column === 0) {
				return checkBoxServiceDelegate;
			    } else if (column === 14)
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
			    color: selectedService ? "#FFCC80" : (row % 2 === 0 ? "#faf2e1" : "#fcecca")
			    clip: true
			    border.color: "#C99A6B"

			    Text {
				anchors.fill: parent
				font.pixelSize: 14
				wrapMode: "Wrap"
				color: "#4A4A4A"
				font.bold: true
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
			    color: selectedService ? "#FFCC80" : (row % 2 === 0 ? "#faf2e1" : "#fcecca")
			    clip: true
			    border.color: "#C99A6B"

			    CheckBox {
				anchors.centerIn: parent
				checked: selectedService

				onCheckedChanged: {
				    customer.getVehicles().getVehicleById(selectedVehicleId).getServices().toggleSelection(index);
				    //customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getSelectedServices();
				}
			    }
			}
		    }

		    Component {
			id: actionFieldDelegate
			Rectangle {
			    width: parent.width
			    height: parent.height
			    color: selectedService ? "#FFCC80" : (row % 2 === 0 ? "#faf2e1" : "#fcecca")
			    border.color: "#C99A6B"
			    clip: true

			    Row {
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				spacing: 4

				Rectangle {
				    id: showServiceButton
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
					id: showServiceMouseArea
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
					    showService(customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByRowQML(row).getId());
					}
				    }

				    ToolTip {
					visible: showServiceMouseArea.containsMouse
					delay: 500
					text: "show"
					x: showServiceMouseArea.x
					y: showServiceMouseArea.y + 30
				    }
				}

				Rectangle {
				    id: editServiceButton
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
					id: editServiceMouseArea
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
					    setSelectedService(customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByRowQML(row).getId());
					    editServiceDialog.openDialog();
					}
				    }

				    ToolTip {
					visible: editServiceMouseArea.containsMouse
					delay: 500
					text: "edit"
					x: editServiceMouseArea.x
					y: editServiceMouseArea.y + 30
				    }
				}

				Rectangle {
				    id: removeServiceButton
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
					id: removeServiceMouseArea
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
					    setSelectedService(customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByRowQML(row).getId());
					    removeServiceDialog.openDialog(false);
					}
				    }
				    ToolTip {
					visible: removeServiceMouseArea.containsMouse
					delay: 500
					text: "remove"
					x: removeServiceMouseArea.x
					y: removeServiceMouseArea.y + 30
				    }
				}
			    }
			}
		    }
		}
		ScrollBar.horizontal: ScrollBar {
		    policy: ScrollBar.AlwaysOn
		    anchors.bottom: parent.bottom
		    clip: true
		}

		ScrollBar.vertical: ScrollBar {
		    policy: ScrollBar.AsNeeded
		    //anchors.left: parent.right
		    clip: true
		}
	    }
	}
	Row {
	    anchors.top: tableViewRect.bottom
	    anchors.topMargin: 12
	    anchors.horizontalCenter: tableViewRect.horizontalCenter
	    spacing: 5

	    Rectangle {
		width: 225
		height: 35
		color: "black"
		radius: 30
		Row {
		    anchors.horizontalCenter: parent.horizontalCenter
		    anchors.verticalCenter: parent.verticalCenter
		    spacing: 3
		    Image {
			width: 30
			height: parent.height - 4
			source: "qrc:/assets/plus.png"
			fillMode: Image.PreserveAspectFit
			anchors.verticalCenter: parent.verticalCenter
		    }

		    Text {
			color: "white"
			font.pixelSize: 20
			text: "Add service"
			anchors.verticalCenter: parent.verticalCenter
		    }
		}

		MouseArea {
		    anchors.fill: parent
		    onClicked: {
			addServiceDialog.openDialog();
		    }
		}
	    }

	    Rectangle {
		width: 225
		height: 35
		color: "black"
		radius: 30
		Row {
		    anchors.horizontalCenter: parent.horizontalCenter
		    anchors.verticalCenter: parent.verticalCenter
		    spacing: 3
		    Image {
			width: 30
			height: parent.height - 4
			source: "qrc:/assets/delete.png"
			fillMode: Image.PreserveAspectFit
			anchors.verticalCenter: parent.verticalCenter
		    }

		    Text {
			color: "white"
			font.pixelSize: 20
			text: "Remove checked"
			anchors.verticalCenter: parent.verticalCenter
		    }
		}

		MouseArea {
		    anchors.fill: parent
		    onClicked: {
			removeServiceDialog.openDialog(true);
		    }
		}
	    }

	    Rectangle {
		width: 225
		height: 35
		color: "black"
		radius: 30
		Row {
		    anchors.horizontalCenter: parent.horizontalCenter
		    anchors.verticalCenter: parent.verticalCenter
		    spacing: 3
		    Image {
			width: 30
			height: parent.height - 4
			source: "qrc:/assets/raport.png"
			fillMode: Image.PreserveAspectFit
			anchors.verticalCenter: parent.verticalCenter
		    }

		    Text {
			color: "white"
			font.pixelSize: 20
			text: "Generate report"
			anchors.verticalCenter: parent.verticalCenter
		    }
		}

		MouseArea {
		    anchors.fill: parent
		    onClicked: {}
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

    EditServiceDialog {
	id: editServiceDialog
    }
    RemoveServiceDialog {
	id: removeServiceDialog
    }
    AddServiceDialog {
	id: addServiceDialog
    }

    function setSelectedService(serviceId) {
	selectedServiceId = serviceId;
    }

    function showService(serviceId) {
	selectedServiceId = serviceId;
	viewLoader.source = "ServiceView.qml";
    }
}
