import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    property string serviceType: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getType()
    property int fontSize: 21

    property int selectedServiceId: -1
    property int selectedVehicleId: -1

    signal backToVehicle(int vehicleId, int serviceId)

    Component.onCompleted: {
	setInfoRowsVisible();
    }

    function setInfoRowsVisible() {
	if (serviceType === "MaintenanceService") {
	    oilRow.visible = false;
	    oilFilterRow.visible = false;
	    airFilterRow.visible = false;
	    cabinFilterRow.visible = false;
	    timingRow.visible = false;
	    customPartsRow.visible = false;
	} else if (serviceType === "RepairService") {
	    oilRow.visible = false;
	    oilFilterRow.visible = false;
	    airFilterRow.visible = false;
	    cabinFilterRow.visible = false;
	    timingRow.visible = false;

	    //customPartsRow.visible = true;
	} else if (serviceType === "ServiceOil") {
	    timingRow.visible = false;
	    customPartsRow.visible = false;
	} else if (serviceType === "ServiceTiming") {
	    oilRow.visible = false;
	    oilFilterRow.visible = false;
	    airFilterRow.visible = false;
	    cabinFilterRow.visible = false;
	    customPartsRow.visible = false;
	}
    }

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
		    backToVehicle(selectedVehicleId, selectedServiceId);
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
	    color: "#FFD9B3"
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
		    source: "qrc:/assets/service.png"
		}
	    }

	    Label {
		id: vehicleInfoLabel
		color: "#212121"
		font.pixelSize: 35
		text: "Service Page"
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
	    id: serviceInfoRect
	    anchors.right: parent.right
	    anchors.top: pageTitleRect.bottom
	    anchors.left: vehicleInfoRect.right
	    anchors.bottom: parent.bottom
	    anchors.topMargin: 30
	    anchors.leftMargin: 30
	    anchors.rightMargin: 20
	    anchors.bottomMargin: 30
	    radius: 30
	    layer.enabled: true
	    clip: true

	    gradient: Gradient {
		GradientStop {
		    position: 0.0
		    color: "#FFC48C"
		}
		// GradientStop {
		//     position: 0.5
		//     color: "#fceac5"
		// }
		GradientStop {
		    position: 1.0
		    color: "#FFD6A5"
		}
	    }

	    Column {
		id: serviceInfoColumn
		spacing: 5
		anchors.fill: parent
		anchors.margins: 20

		Label {
		    text: "Service Information"
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
		    id: mileageRow
		    spacing: 10
		    width: parent.width
		    //width: parent.width
		    Label {
			id: mileageLabel
			text: "Mileage:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getMileage()
			font.pixelSize: fontSize
			color: "#333333"
			wrapMode: "Wrap"
			width: parent.width - modelLabel.width
		    }
		}

		Row {
		    id: typeRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: typeServiceLabel
			text: "Type:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getType()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - typeServiceLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    id: intervalKmRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: intervalKmLabel
			text: "Interval Kilometers:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_km()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - intervalKmLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    id: serviceDateRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: serviceDateLabel
			text: "Service date:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getServiceDateAsString().toString()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - serviceDateLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    id: intervalTimeRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: intervalTimeLabel
			text: "Interval months:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_time()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - intervalTimeLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    id: serviceRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: serviceLabel
			text: "Service:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getService()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - serviceLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    id: oilRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: oilLabel
			text: "Oil:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getOil()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - oilLabel.width
			wrapMode: "Wrap"
		    }
		}
		Row {
		    id: oilFilterRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: oilFilterLabel
			text: "Oil filter:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getOilFilter()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - oilFilterLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    id: airFilterRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: airFilterLabel
			text: "Air filter:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getAirFilter()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - airFilterLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    id: cabinFilterRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: cabinFilterLabel
			text: "Cabin filter:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getCabinFilter()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - cabinFilterLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    id: timingRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: timingLabel
			text: "Timing:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getTiming()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - timingLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    id: customPartsRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: customPartsLabel
			text: "Custom parts:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getCustomParts()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - customPartsLabel.width
			wrapMode: "Wrap"
		    }
		}

		Row {
		    id: noteRow
		    spacing: 10
		    width: parent.width
		    Label {
			id: noteLabel
			text: "Note:"
			font.pixelSize: fontSize
			color: "#555555"
			font.bold: true
		    }
		    Label {
			text: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getNote()
			font.pixelSize: fontSize
			color: "#333333"
			width: parent.width - noteLabel.width
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
	    source: serviceInfoRect
	    anchors.fill: serviceInfoRect
	    shadowBlur: 1.0
	    shadowEnabled: true
	    shadowColor: "black"
	    shadowVerticalOffset: 0
	    shadowHorizontalOffset: 0
	}
    }

    function goBackToVehicle() {
	viewLoader.source = "VehicleView.qml";
    }
}
