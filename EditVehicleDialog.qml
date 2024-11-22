import QtQuick
import QtQuick.Controls

Item {
    id: editVehicleDialogContainer
    function openDialog() {
	editVehicleDialog.open();
    }

    Dialog {
	id: editVehicleDialog
	anchors.centerIn: parent
	width: 450
	height: 630
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Edit vehicle"

	Column {
	    id: editVehicleColumn
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter

	    TextField {
		id: editBrandInput
		background: Rectangle {
		    id: editBrandTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editBrandTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Brand (" + customer.getVehicles().getVehicleById(selectedVehicleId).getBrand() + ")"
	    }

	    Label {
		id: wrongEditBrandInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Brand should contain only letters!"
	    }

	    TextField {
		id: editModelInput
		background: Rectangle {
		    id: editModelTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editModelTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Model (" + customer.getVehicles().getVehicleById(selectedVehicleId).getModel() + ")"
	    }
	    Label {
		id: wrongEditModelInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Model should not be empty"
	    }

	    TextField {
		id: editYearInput
		background: Rectangle {
		    id: editYearTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editYearTextRect.width
		validator: RegularExpressionValidator {
		    regularExpression: /^[0-9]*$/
		}
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Year (" + customer.getVehicles().getVehicleById(selectedVehicleId).getYear() + ")"
	    }

	    Label {
		id: wrongEditYearInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Year should contain only digits! (1900-2025)"
	    }

	    TextField {
		id: editVersionInput
		background: Rectangle {
		    id: editVersionTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editVersionTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Version (" + customer.getVehicles().getVehicleById(selectedVehicleId).getVersion() + ")"
	    }
	    Label {
		id: wrongEditVersionInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Version should not be empty!"
	    }

	    TextField {
		id: editEngineInput
		background: Rectangle {
		    id: editEngineTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editEngineTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Engine (" + customer.getVehicles().getVehicleById(selectedVehicleId).getEngine() + ")"
	    }
	    Label {
		id: wrongEditEngineInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Engine should not be empty!"
	    }

	    TextField {
		id: editVinInput
		background: Rectangle {
		    id: editVinTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editVinTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "VIN (" + customer.getVehicles().getVehicleById(selectedVehicleId).getVin() + ")"
	    }

	    Label {
		id: wrongEditVinInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "VIN should contain 17 characters! (Digits and capital letters without O,I,Q)"
	    }

	    TextField {
		id: editRegistrationInput
		background: Rectangle {
		    id: editRegistrationTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editRegistrationTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Registration (" + customer.getVehicles().getVehicleById(selectedVehicleId).getRegistrationNumber() + ")"
	    }
	    Label {
		id: wrongEditRegistrationInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Registration should not be empty!"
	    }

	    Row {
		spacing: 5
		ComboBox {
		    id: vehicleEditTypeComboBox
		    model: vehicleTypeModel
		    textRole: "typeName"
		    width: implicitWidth + 50
		    currentIndex: vehicleTypeModel.findIndex(customer.getVehicles().getVehicleById(selectedVehicleId).getTypeInt())
		    onCurrentIndexChanged: {
			console.log("Selected Vehicle Type:", vehicleTypeModel.get(currentIndex).typeName);
		    }
		}

		Rectangle {
		    id: addEditTypeButton
		    width: 100
		    height: 30
		    color: "white"
		    radius: 5
		    border.color: "black"
		    scale: 1.0
		    anchors.verticalCenter: vehicleEditTypeComboBox.verticalCenter
		    Text {
			text: "New type"
			font.pixelSize: 15
			anchors.centerIn: parent
			color: "black"
		    }

		    MouseArea {
			anchors.fill: parent
			onClicked: {
			    newTypeDialog.open();
			}
		    }
		}
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
		    let isValid = true;
		    if (editModelInput.text !== "") {
			if (!valid.modelIsValid(editModelInput.text)) {
			    wrongEditModelInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditModelInput.visible = false;
			}
		    }
		    if (editBrandInput.text !== "") {
			if (!valid.markIsValid(editBrandInput.text)) {
			    wrongEditBrandInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditBrandInput.visible = false;
			}
		    }
		    if (editYearInput.text !== "") {
			if (!valid.yearIsValid(editYearInput.text)) {
			    wrongEditYearInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditYearInput.visible = false;
			}
		    }
		    if (editEngineInput.text !== "") {
			if (!valid.engineIsValid(editEngineInput.text)) {
			    wrongEditEngineInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditEngineInput.visible = false;
			}
		    }
		    if (editVersionInput.text !== "") {
			if (!valid.versionIsValid(editVersionInput.text)) {
			    wrongEditVersionInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditVersionInput.visible = false;
			}
		    }
		    if (editVinInput.text !== "") {
			if (!valid.vinIsValid(editVinInput.text)) {
			    wrongEditVinInput.text = "VIN should contain 17 characters withoud O, I and Q";
			    wrongEditVinInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditVinInput.visible = false;
			}
		    }
		    if (editRegistrationInput.text !== "") {
			if (!valid.regNumberIsValid(editRegistrationInput.text)) {
			    wrongEditRegistrationInput.text = "Registration should not be empty!";
			    wrongEditRegistrationInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditRegistrationInput.visible = false;
			}
		    }
		    if (isValid) {
			if (!dbController.checkVin(editVinInput.text)) {
			    if (!dbController.checkRegistration(editRegistrationInput.text)) {
				if (dbController.updateVehicle(selectedVehicleId, editBrandInput.text, editModelInput.text, editYearInput.text, editVersionInput.text, editEngineInput.text, vehicleTypeModel.get(vehicleEditTypeComboBox.currentIndex).id, vehicleTypeModel.get(vehicleEditTypeComboBox.currentIndex).typeName, editVinInput.text, editRegistrationInput.text)) {
				    customer.fetchVehicles(customer.getId());
				    editVehicleDialog.close();
				}
			    } else {
				wrongEditRegistrationInput.text = "That registration already exists!";
				wrongEditRegistrationInput.visible = true;
			    }
			} else {
			    wrongEditVinInput.text = "That vin already exists!";
			    wrongEditVinInput.visible = true;
			}
		    }
		}
	    }
	    Button {
		text: "Cancel"
		onClicked: editVehicleDialog.close()
	    }
	}
    }
}
