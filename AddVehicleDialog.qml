import QtQuick
import QtQuick.Controls

Item {
    id: addVehicleDialogContainer
    function openDialog() {
	addVehicleDialog.open();
    }

    function clearInputs() {
	brandInput.text = "";
	modelInput.text = "";
	yearInput.text = "";
	versionInput.text = "";
	engineInput.text = "";
	vinInput.text = "";
	registrationInput.text = "";
    }

    Dialog {
	id: addVehicleDialog
	anchors.centerIn: parent
	width: 450
	height: 630
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Add vehicle"

	Column {
	    id: addVehicleColumn
	    spacing: 7
	    anchors.horizontalCenter: parent.horizontalCenter

	    TextField {
		id: brandInput
		width: 350
		height: 30
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Brand"
	    }

	    Label {
		id: wrongBrandInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Brand should contain only letters!"
	    }

	    TextField {
		id: modelInput
		width: 350
		height: 30
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Model"
	    }
	    Label {
		id: wrongModelInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Model should not be empty"
	    }

	    TextField {
		id: yearInput
		width: 350
		height: 30
		validator: RegularExpressionValidator {
		    regularExpression: /^[0-9]*$/
		}
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Year"
	    }

	    Label {
		id: wrongYearInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "The year must be between 1900 and 2025"
	    }

	    TextField {
		id: versionInput
		width: 350
		height: 30
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Version"
	    }
	    Label {
		id: wrongVersionInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Version should not be empty!"
	    }

	    TextField {
		id: engineInput
		width: 350
		height: 30
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Engine"
	    }
	    Label {
		id: wrongEngineInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Engine should not be empty!"
	    }

	    TextField {
		id: vinInput
		width: 350
		height: 30
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "VIN"
	    }

	    Label {
		id: wrongVinInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "VIN should contain 17 characters!"
	    }

	    TextField {
		id: registrationInput
		width: 350
		height: 30
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Registration number"
	    }
	    Label {
		id: wrongRegistrationInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Registration should not be empty!"
	    }

	    Row {
		spacing: 5

		ComboBox {
		    id: vehicleTypeComboBox
		    model: vehicleTypeModel
		    textRole: "typeName"
		    width: implicitWidth + 50
		    onCurrentIndexChanged: {
			console.log("Selected Vehicle Type:", vehicleTypeModel.get(currentIndex).typeName);
		    }
		}

		Rectangle {
		    id: addTypeButton
		    width: 100
		    height: 30
		    color: "white"
		    radius: 5
		    border.color: "black"
		    scale: 1.0
		    anchors.verticalCenter: vehicleTypeComboBox.verticalCenter
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

		Label {
		    id: wrongType
		    visible: false
		    font.pixelSize: 10
		    color: "red"
		    text: "Choose a type!"
		    anchors.verticalCenter: vehicleTypeComboBox.verticalCenter
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
		    if (!valid.modelIsValid(modelInput.text)) {
			wrongModelInput.visible = true;
			isValid = false;
		    } else {
			wrongModelInput.visible = false;
		    }
		    if (!valid.markIsValid(brandInput.text)) {
			wrongBrandInput.visible = true;
			isValid = false;
		    } else {
			wrongBrandInput.visible = false;
		    }
		    if (!valid.yearIsValid(yearInput.text)) {
			wrongYearInput.visible = true;
			isValid = false;
		    } else {
			wrongYearInput.visible = false;
		    }
		    if (!valid.engineIsValid(engineInput.text)) {
			wrongEngineInput.visible = true;
			isValid = false;
		    } else {
			wrongEngineInput.visible = false;
		    }
		    if (!valid.versionIsValid(versionInput.text)) {
			wrongVersionInput.visible = true;
			isValid = false;
		    } else {
			wrongVersionInput.visible = false;
		    }
		    if (vehicleTypeComboBox.currentIndex === -1) {
			wrongType.visible = true;
			isValid = false;
		    } else {
			wrongType.visible = false;
		    }
		    if (!valid.vinIsValid(vinInput.text)) {
			wrongVinInput.text = "VIN should contain 17 characters withoud O, I and Q";
			wrongVinInput.visible = true;
			isValid = false;
		    } else {
			wrongVinInput.visible = false;
		    }
		    if (!valid.regNumberIsValid(registrationInput.text)) {
			wrongRegistrationInput.text = "Registration should not be empty!";
			wrongRegistrationInput.visible = true;
			isValid = false;
		    } else {
			wrongRegistrationInput.visible = false;
		    }
		    if (isValid) {
			if (!dbController.checkVin(vinInput.text)) {
			    if (!dbController.checkRegistration(registrationInput.text)) {
				if (dbController.addVehicle(customer.getId(), brandInput.text, modelInput.text, yearInput.text, versionInput.text, engineInput.text, vehicleTypeModel.get(vehicleTypeComboBox.currentIndex).id, vehicleTypeModel.get(vehicleTypeComboBox.currentIndex).typeName, vinInput.text, registrationInput.text)) {
				    customer.fetchVehicles(customer.getId());
				    clearInputs();
				    addVehicleDialog.close();
				}
			    } else {
				wrongRegistrationInput.text = "That registration already exists!";
				wrongRegistrationInput.visible = true;
			    }
			} else {
			    wrongVinInput.text = "That vin already exists!";
			    wrongVinInput.visible = true;
			}
		    }
		}
	    }

	    Button {
		text: "Cancel"
		onClicked: addVehicleDialog.close()
	    }
	}
    }
}
