import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: editServiceDialogContainer
    property string type: customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getType()

    //property string date: ""

    function setPlaceholderTexts() {
	if (type == "MaintenanceService") {
	    mileageInput.placeholderText = "Mileage (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getMileage() + ")";
	    //intervalDateInput.placeholderText =
	    intervalKmInput.placeholderText = "Interval kilometers (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_km() + ")";
	    serviceInput.placeholderText = "Service (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getService() + ")";
	    intervalDateInput.placeholderText = "Interval months (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_time() + ")";
	} else if (type == "RepairService") {
	    mileageInput.placeholderText = "Mileage (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getMileage() + ")";
	    //intervalDateInput.placeholderText =
	    intervalKmInput.placeholderText = "Interval kilometers (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_km() + ")";
	    serviceInput.placeholderText = "Service (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getService() + ")";
	    intervalDateInput.placeholderText = "Interval months (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_time() + ")";
	    partsInput.placeholderText = "Repair parts (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getCustomParts() + ")";
	} else if (type == "ServiceOil") {
	    mileageInput.placeholderText = "Mileage (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getMileage() + ")";
	    //intervalDateInput.placeholderText =
	    intervalKmInput.placeholderText = "Interval kilometers (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_km() + ")";
	    serviceInput.placeholderText = "Service (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getService() + ")";
	    intervalDateInput.placeholderText = "Interval months (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_time() + ")";
	    oilInput.placeholderText = "Oil (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getOil() + ")";
	    oilFilterInput.placeholderText = "Oil filter (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getOilFilter() + ")";
	    airFilterInput.placeholderText = "Air filter (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getAirFilter() + ")";
	    cabinFilterInput.placeholderText = "Cabin filter (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getCabinFilter() + ")";
	} else if (type == "ServiceTiming") {
	    mileageInput.placeholderText = "Mileage (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getMileage() + ")";
	    //intervalDateInput.placeholderText =
	    intervalKmInput.placeholderText = "Interval kilometers (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_km() + ")";
	    serviceInput.placeholderText = "Service (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getService() + ")";
	    intervalDateInput.placeholderText = "Interval months (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getInterval_time() + ")";
	    timingInput.placeholderText = "Timing (" + customer.getVehicles().getVehicleById(selectedVehicleId).getServices().getServiceByIdQML(selectedServiceId).getTiming() + ")";
	}
    }

    function setTextFieldsVisible() {
	if (type == "MaintenanceService") {
	    mileageInput.visible = true;
	    intervalDateInput.visible = true;
	    intervalKmInput.visible = true;
	    serviceInput.visible = true;
	    oilFilterInput.visible = false;
	    oilInput.visible = false;
	    timingInput.visible = false;
	    cabinFilterInput.visible = false;
	    airFilterInput.visible = false;
	    partsInput.visible = false;
	    setPlaceholderTexts();
	} else if (type == "RepairService") {
	    mileageInput.visible = true;
	    intervalDateInput.visible = true;
	    intervalKmInput.visible = true;
	    serviceInput.visible = true;
	    oilFilterInput.visible = false;
	    oilInput.visible = false;
	    timingInput.visible = false;
	    cabinFilterInput.visible = false;
	    airFilterInput.visible = false;
	    partsInput.visible = true;
	    setPlaceholderTexts();
	} else if (type == "ServiceOil") {
	    mileageInput.visible = true;
	    intervalDateInput.visible = true;
	    intervalKmInput.visible = true;
	    serviceInput.visible = true;
	    oilFilterInput.visible = true;
	    oilInput.visible = true;
	    timingInput.visible = false;
	    cabinFilterInput.visible = true;
	    airFilterInput.visible = true;
	    partsInput.visible = false;
	    setPlaceholderTexts();
	} else if (type == "ServiceTiming") {
	    mileageInput.visible = true;
	    intervalDateInput.visible = true;
	    intervalKmInput.visible = true;
	    serviceInput.visible = true;
	    oilFilterInput.visible = false;
	    oilInput.visible = false;
	    timingInput.visible = true;
	    cabinFilterInput.visible = false;
	    airFilterInput.visible = false;
	    partsInput.visible = false;
	    setPlaceholderTexts();
	}
    }

    function openDialog() {
	editServiceDialog.open();
	setTextFieldsVisible();
    }

    Dialog {
	id: editServiceDialog
	anchors.centerIn: parent
	width: 800
	height: 700
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Edit service"

	Column {
	    id: editServiceColumn
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter

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
			placeholderText: "Mileage"
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
			placeholderText: "Interval kilometers"
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
			placeholderText: "Interval months"
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
			placeholderText: "Service"
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
			placeholderText: "Oil"
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
			placeholderText: "Oil filter"
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
			placeholderText: "Air filter"
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
			placeholderText: "Cabin filter"
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
			placeholderText: "Timing"
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
			placeholderText: "Repair parts"
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

	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter

		Button {
		    text: "Ok"
		    onClicked: {
			let isValid = true;
			if (mileageInput.text !== "") {
			    if (!valid.mileageIsValid(mileageInput.text)) {
				wrongMileageInput.visible = true;
				isValid = false;
			    } else
				wrongMileageInput.visible = false;
			}
			if (intervalKmInput.text !== "") {
			    if (!valid.intervalKmIsValid(intervalKmInput.text)) {
				wrongIntervalKmInput.visible = true;
				isValid = false;
			    } else
				wrongIntervalKmInput.visible = false;
			}
			// if (!valid.serviceDateIsValid(ddInput.text, mmInput.text, yyInput.text)) {
			//     wrongServiceDateInput.visible = true;
			//     isValid = false;
			// } else
			//     wrongServiceDateInput.visible = false;
			if (serviceInput.text !== "") {
			    if (!valid.serviceIsValid(serviceInput.text)) {
				wrongServiceInput.visible = true;
				isValid = false;
			    } else
				wrongServiceInput.visible = false;
			}
			if (oilInput.text !== "") {
			    if (!valid.oilIsValid(oilInput.text)) {
				wrongOilInput.visible = true;
				isValid = false;
			    } else
				wrongOilInput.visible = false;
			}
			if (oilFilterInput.text !== "") {
			    if (!valid.oilFilterIsValid(oilFilterInput.text)) {
				wrongOilFilterInput.visible = true;
				isValid = false;
			    } else
				wrongOilFilterInput.visible = false;
			}
			if (airFilterInput.text !== "") {
			    if (!valid.airFilterIsValid(airFilterInput.text)) {
				wrongAirFilterInput.visible = true;
				isValid = false;
			    } else
				wrongAirFilterInput.visible = false;
			}
			if (cabinFilterInput.text !== "") {
			    if (!valid.cabinFilterIsValid(cabinFilterInput.text)) {
				wrongCabinFilterInput.visible = true;
				isValid = false;
			    } else
				wrongCabinFilterInput.visible = false;
			}
			if (timingInput.text !== "") {
			    if (!valid.timingIsValid(timingInput.text)) {
				wrongTimingInput.visible = true;
				isValid = false;
			    } else
				wrongTimingInput.visible = false;
			}
			if (partsInput.text !== "") {
			    if (!valid.customPartsIsValid(partsInput.text)) {
				wrongPartsInput.visible = true;
				isValid = false;
			    } else
				wrongPartsInput.visible = false;
			}
			if (isValid) {
			    wrongMileageInput.visible = false;
			    wrongAirFilterInput.visible = false;
			    wrongCabinFilterInput.visible = false;
			    //wrongIntervalDateInput.visible = false;
			    wrongIntervalKmInput.visible = false;
			    wrongOilFilterInput.visible = false;
			    wrongOilInput.visible = false;
			    wrongServiceInput.visible = false;
			    wrongTimingInput.visible = false;
			    wrongPartsInput.visible = false;

			    //date = yyInput.text + "-" + mmInput.text + "-" + ddInput.text;
			    if (dbController.updateService(selectedServiceId, mileageInput.text, intervalKmInput.text,intervalDateInput.text ,serviceInput.text, oilInput.text, oilFilterInput.text, airFilterInput.text, cabinFilterInput.text, timingInput.text, partsInput.text))
				;
			    {
				console.log("Service updated successfully");
				editServiceDialog.close();
			    }
			}
		    }
		}
		Button {
		    text: "Cancel"
		    onClicked: editServiceDialog.close()
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
    }
}

//    Label {
// text: "Service date: "
// font.pixelSize: 15
// anchors.horizontalCenter: parent.horizontalCenter
//    }
//    Row {

// anchors.horizontalCenter: parent.horizontalCenter
// spacing: 5
// TextField {
//     id: ddInput
//     background: Rectangle {
// 	id: ddTextRect
// 	color: "white"
// 	radius: 10
// 	width: 60
// 	height: 30
// 	border.color: "lightgray"
//     }
//     implicitWidth: ddTextRect.width
//     wrapMode: "Wrap"
//     font.pixelSize: 15
//     placeholderText: "DD"
//     validator: RegularExpressionValidator {
// 	regularExpression: /^(0?[1-9]|[12][0-9]|3[01])$/
//     }
// }

// TextField {
//     id: mmInput
//     background: Rectangle {
// 	id: mmTextRect
// 	color: "white"
// 	radius: 10
// 	width: 60
// 	height: 30
// 	border.color: "lightgray"
//     }
//     implicitWidth: mmTextRect.width
//     wrapMode: "Wrap"
//     font.pixelSize: 15
//     placeholderText: "MM"
//     validator: RegularExpressionValidator {
// 	regularExpression: /^(0?[1-9]|1[0-2])$/
//     }
// }

// TextField {
//     id: yyInput
//     background: Rectangle {
// 	id: yyTextRect
// 	color: "white"
// 	radius: 10
// 	width: 70
// 	height: 30
// 	border.color: "lightgray"
//     }
//     implicitWidth: yyTextRect.width
//     wrapMode: "Wrap"
//     font.pixelSize: 15
//     placeholderText: "YYYY"
//     validator: RegularExpressionValidator {
// 	regularExpression: /^(1[9]|2[0])[0-9]{2}$/
//     }
// }
//    }

//    Label {
// id: wrongServiceDateInput
// text: "Invalid date"
// visible: false
// font.pixelSize: 10
// color: "red"
// anchors.horizontalCenter: parent.horizontalCenter
//    }
