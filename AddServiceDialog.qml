import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: addServiceDialogContainer
    property string type: ""
    function openDialog() {
	addServiceDialog.open();
    }

    Dialog {
	id: addServiceDialog
	anchors.centerIn: parent
	width: 800
	height: 700
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Add service"

	Column {
	    id: addServiceColumn
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter

	    Label {
		text: "Choose the type of service"
		font.pixelSize: 23
		anchors.horizontalCenter: parent.horizontalCenter
	    }

	    Row {
		anchors.horizontalCenter: parent.horizontalCenter
		RadioButton {
		    id: maintenanceRadioButton
		    text: qsTr("Maintenance Service")
		    checked: true
		    onToggled: {
			if (checked) {
			    mileageInput.visible = true;
			    intervalDateInput.visible = true;
			    intervalKmInput.visible = true;
			    ddInput.visible = true;
			    mmInput.visible = true;
			    yyInput.visible = true;
			    serviceInput.visible = true;
			    oilFilterInput.visible = false;
			    oilInput.visible = false;
			    timingInput.visible = false;
			    cabinFilterInput.visible = false;
			    airFilterInput.visible = false;
			    partsInput.visible = false;
			    type = "MaintenanceService";
			} else {
			    wrongMileageInput.visible = false;
			    wrongAirFilterInput.visible = false;
			    wrongCabinFilterInput.visible = false;
			    wrongIntervalDateInput.visible = false;
			    wrongIntervalKmInput.visible = false;
			    wrongOilFilterInput.visible = false;
			    wrongOilInput.visible = false;
			    wrongServiceInput.visible = false;
			    wrongTimingInput.visible = false;
			    wrongPartsInput.visible = false;
			}
		    }
		}
		RadioButton {
		    id: repairRadioButton
		    text: qsTr("Repair Service")
		    onToggled: {
			if (checked) {
			    mileageInput.visible = true;
			    intervalDateInput.visible = true;
			    intervalKmInput.visible = true;
			    ddInput.visible = true;
			    mmInput.visible = true;
			    yyInput.visible = true;
			    serviceInput.visible = true;
			    oilFilterInput.visible = false;
			    oilInput.visible = false;
			    timingInput.visible = false;
			    cabinFilterInput.visible = false;
			    airFilterInput.visible = false;
			    partsInput.visible = true;
			    type = "RepairService";
			} else {
			    wrongMileageInput.visible = false;
			    wrongAirFilterInput.visible = false;
			    wrongCabinFilterInput.visible = false;
			    wrongIntervalDateInput.visible = false;
			    wrongIntervalKmInput.visible = false;
			    wrongOilFilterInput.visible = false;
			    wrongOilInput.visible = false;
			    wrongServiceInput.visible = false;
			    wrongTimingInput.visible = false;
			    wrongPartsInput.visible = false;
			}
		    }
		}
		RadioButton {
		    id: oilRadioButton
		    text: qsTr("Oil Service")
		    onToggled: {
			onToggled: {
			    if (checked) {
				mileageInput.visible = true;
				intervalDateInput.visible = true;
				intervalKmInput.visible = true;
				ddInput.visible = true;
				mmInput.visible = true;
				yyInput.visible = true;
				serviceInput.visible = true;
				oilFilterInput.visible = true;
				oilInput.visible = true;
				timingInput.visible = false;
				cabinFilterInput.visible = true;
				airFilterInput.visible = true;
				partsInput.visible = false;
				type = "OilService";
			    } else {
				wrongMileageInput.visible = false;
				wrongAirFilterInput.visible = false;
				wrongCabinFilterInput.visible = false;
				wrongIntervalDateInput.visible = false;
				wrongIntervalKmInput.visible = false;
				wrongOilFilterInput.visible = false;
				wrongOilInput.visible = false;
				wrongServiceInput.visible = false;
				wrongTimingInput.visible = false;
				wrongPartsInput.visible = false;
			    }
			}
		    }
		}
		RadioButton {
		    id: timingRadioButton
		    text: qsTr("Timing Service")
		    onToggled: {
			if (checked) {
			    mileageInput.visible = true;
			    intervalDateInput.visible = true;
			    intervalKmInput.visible = true;
			    ddInput.visible = true;
			    mmInput.visible = true;
			    yyInput.visible = true;
			    serviceInput.visible = true;
			    oilFilterInput.visible = false;
			    oilInput.visible = false;
			    timingInput.visible = true;
			    cabinFilterInput.visible = false;
			    airFilterInput.visible = false;
			    partsInput.visible = false;
			    type = "TimingService";
			} else {
			    wrongMileageInput.visible = false;
			    wrongAirFilterInput.visible = false;
			    wrongCabinFilterInput.visible = false;
			    wrongIntervalDateInput.visible = false;
			    wrongIntervalKmInput.visible = false;
			    wrongOilFilterInput.visible = false;
			    wrongOilInput.visible = false;
			    wrongServiceInput.visible = false;
			    wrongTimingInput.visible = false;
			    wrongPartsInput.visible = false;
			}
		    }
		}

		//Make textfields for all attributes and then in functions make visible only the ones that specified type requires
	    }
	    Label {
		text: "Service date: "
		font.pixelSize: 15
		anchors.horizontalCenter: parent.horizontalCenter
		//anchors.verticalCenter: ddInput.verticalCenter
	    }
	    Row {

		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 5
		TextField {
		    id: ddInput
		    background: Rectangle {
			id: ddTextRect
			color: "white"
			radius: 10
			width: 60
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: ddTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "DD"
		    validator: RegularExpressionValidator {
			regularExpression: /^(0?[1-9]|[12][0-9]|3[01])$/
		    }
		}

		TextField {
		    id: mmInput
		    background: Rectangle {
			id: mmTextRect
			color: "white"
			radius: 10
			width: 60
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: mmTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "MM"
		    validator: RegularExpressionValidator {
			regularExpression: /^(0?[1-9]|1[0-2])$/
		    }
		}

		TextField {
		    id: yyInput
		    background: Rectangle {
			id: yyTextRect
			color: "white"
			radius: 10
			width: 70
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: yyTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "YYYY"
		    validator: RegularExpressionValidator {
			regularExpression: /^(1[9]|2[0])[0-9]{2}$/
		    }
		}
	    }

	    Row {
		spacing: 5
		TextField {
		    id: mileageInput
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
		    placeholderText: "Mileage...                      "
		}

		Label {
		    id: wrongMileageInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Mileage should contain only digits!"
		}

		TextField {
		    id: intervalKmInput
		    background: Rectangle {
			id: intervalKmTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: intervalKmTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Interval kilometers...                      "
		}

		Label {
		    id: wrongIntervalKmInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Interval kilometers should contain only digits!"
		}
	    }
	    Row {
		spacing: 5
		TextField {
		    id: intervalDateInput
		    background: Rectangle {
			id: intervalDateTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: intervalDateTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Interval in months                      "
		}

		Label {
		    id: wrongIntervalDateInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Interval months should contain only digits!"
		}

		TextField {
		    id: serviceInput
		    background: Rectangle {
			id: serviceTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: serviceTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Service...                      "
		}

		Label {
		    id: wrongServiceInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong service input!"
		}
	    }

	    Row {
		spacing: 5
		TextField {
		    id: oilInput
		    background: Rectangle {
			id: oilTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: oilTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Oil...                      "
		    visible: false
		}

		Label {
		    id: wrongOilInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong oil input!"
		}

		TextField {
		    id: oilFilterInput
		    background: Rectangle {
			id: oilFilterTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: oilFilterTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Oil filter...                      "
		    visible: false
		}

		Label {
		    id: wrongOilFilterInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong oil filter input!"
		}
	    }
	    Row {
		spacing: 5
		TextField {
		    id: airFilterInput
		    background: Rectangle {
			id: airFilterTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: airFilterTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Air filter...                      "
		    visible: false
		}

		Label {
		    id: wrongAirFilterInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong air filter input!"
		}

		TextField {
		    id: cabinFilterInput
		    background: Rectangle {
			id: cabinFilterTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: oilFilterTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Cabin filter...                      "
		    visible: false
		}

		Label {
		    id: wrongCabinFilterInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong cabin filter input!"
		}
	    }

	    Row {
		spacing: 5
		TextField {
		    id: timingInput
		    background: Rectangle {
			id: timingTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: timingTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Timing...                      "
		    visible: false
		}

		Label {
		    id: wrongTimingInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong timing input!"
		}

		TextField {
		    id: partsInput
		    background: Rectangle {
			id: partsTextRect
			color: "white"
			radius: 10
			width: 350
			height: 30
			border.color: "lightgray"
		    }
		    implicitWidth: partsTextRect.width
		    wrapMode: "Wrap"
		    font.pixelSize: 15
		    placeholderText: "Repair parts...            "
		    visible: false
		}

		Label {
		    id: wrongPartsInput
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Wrong parts input!"
		}
	    }

	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter
		Button {
		    text: "Cancel"
		    onClicked: addServiceDialog.close()
		}
	    }
	}
    }
}
