import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: addServiceDialogContainer
    property string type: "MaintenanceService"
    property string date: ""

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
			clearInputs();
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
			    wrongNoteInput.visible = false;
			}
		    }
		}
		RadioButton {
		    id: repairRadioButton
		    text: qsTr("Repair Service")
		    onToggled: {
			clearInputs();
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
			    clearInputs();
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
				type = "ServiceOil";
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
			clearInputs();
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
			    type = "ServiceTiming";
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
	    Label {
		text: "Service date: "
		font.pixelSize: 15
		anchors.horizontalCenter: parent.horizontalCenter
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

	    Label {
		id: wrongServiceDateInput
		text: "Invalid date"
		visible: false
		font.pixelSize: 10
		color: "red"
		anchors.horizontalCenter: parent.horizontalCenter
	    }

	    Row {
		spacing: 5
		Column {
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
			validator: RegularExpressionValidator {
			    regularExpression: /^\d+$/
			}
		    }

		    Label {
			id: wrongMileageInput
			visible: false
			font.pixelSize: 10
			color: "red"
			text: "Mileage should be 0 or more and contain only digits!"
		    }
		}
		Column {
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
			validator: RegularExpressionValidator {
			    regularExpression: /^\d+$/
			}
		    }

		    Label {
			id: wrongIntervalKmInput
			visible: false
			font.pixelSize: 10
			color: "red"
			text: "Interval kilometers should contain only digits!"
		    }
		}
	    }
	    Row {
		spacing: 5
		Column {
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
			validator: RegularExpressionValidator {
			    regularExpression: /^\d+$/
			}
		    }

		    Label {
			id: wrongIntervalDateInput
			visible: false
			font.pixelSize: 10
			color: "red"
			text: "Interval months should contain only digits!"
		    }
		}
		Column {

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
	    }

	    Row {
		spacing: 5
		Column {
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
		}
		Column {

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
	    }
	    Row {
		spacing: 5
		Column {
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
		}
		Column {

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
	    }

	    Row {
		spacing: 5
		Column {
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
		}
		Column {

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
	    }

	    TextField {
		id: noteInput
		background: Rectangle {
		    id: noteTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 130
		    border.color: "lightgray"
		}
		implicitWidth: noteTextRect.width
		implicitHeight: noteTextRect.height
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Note (optional)...            "
		horizontalAlignment: Text.AlignLeft
		verticalAlignment: Text.AlignTop
	    }

	    Label {
		id: wrongNoteInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Wrong note input! Maximum size: 255 characters"
	    }

	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter

		Button {
		    text: "Ok"
		    onClicked: {
			let isValid = true;
			if (!valid.mileageIsValid(mileageInput.text)) {
			    wrongMileageInput.visible = true;
			    isValid = false;
			} else
			    wrongMileageInput.visible = false;
			if (!valid.intervalKmIsValid(intervalKmInput.text)) {
			    wrongIntervalKmInput.visible = true;
			    isValid = false;
			} else
			    wrongIntervalKmInput.visible = false;
			if (!valid.serviceDateIsValid(ddInput.text, mmInput.text, yyInput.text)) {
			    wrongServiceDateInput.visible = true;
			    isValid = false;
			} else
			    wrongServiceDateInput.visible = false;
			if (!valid.serviceIsValid(serviceInput.text)) {
			    wrongServiceInput.visible = true;
			    isValid = false;
			} else
			    wrongServiceInput.visible = false;
			if (!valid.oilIsValid(oilInput.text)) {
			    wrongOilInput.visible = true;
			    isValid = false;
			} else
			    wrongOilInput.visible = false;
			if (!valid.oilFilterIsValid(oilFilterInput.text)) {
			    wrongOilFilterInput.visible = true;
			    isValid = false;
			} else
			    wrongOilFilterInput.visible = false;
			if (!valid.airFilterIsValid(airFilterInput.text)) {
			    wrongAirFilterInput.visible = true;
			    isValid = false;
			} else
			    wrongAirFilterInput.visible = false;
			if (!valid.cabinFilterIsValid(cabinFilterInput.text)) {
			    wrongCabinFilterInput.visible = true;
			    isValid = false;
			} else
			    wrongCabinFilterInput.visible = false;
			if (!valid.timingIsValid(timingInput.text)) {
			    wrongTimingInput.visible = true;
			    isValid = false;
			} else
			    wrongTimingInput.visible = false;
			if (!valid.customPartsIsValid(partsInput.text)) {
			    wrongPartsInput.visible = true;
			    isValid = false;
			} else
			    wrongPartsInput.visible = false;
			if (!valid.noteIsValid(noteInput.text)) {
			    wrongNoteInput.visible = true;
			    isValid = false;
			} else
			    wrongPartsInput.visible = false;
			if (isValid) {
			    date = yyInput.text + "-" + mmInput.text + "-" + ddInput.text;
			    if (dbController.addService(customer.getId(), customer.getVehicles().getVehicleById(selectedVehicleId).getId(), mileageInput.text, type, intervalKmInput.text, date, intervalDateInput.text, serviceInput.text, oilInput.text, oilFilterInput.text, airFilterInput.text, cabinFilterInput.text, timingInput.text, partsInput.text, noteInput.text, customer.getVehicles().getVehicleById(selectedVehicleId).getRegistrationNumber())) {
				customer.fetchServicesVersionSpecifiedVehicle(selectedVehicleId);
				notifModel.fetchNotifications(customer.getId());
				console.log("Service added successfully");
				addServiceDialog.close();
			    }
			}
		    }
		}

		Button {
		    text: "Cancel"
		    onClicked: addServiceDialog.close()
		}
	    }
	}
    }

    function clearInputs() {
	oilInput.text = "";
	oilFilterInput.text = "";
	timingInput.text = "";
	cabinFilterInput.text = "";
	airFilterInput.text = "";
	partsInput.text = "";
	noteInput.text = "";
    }
}
