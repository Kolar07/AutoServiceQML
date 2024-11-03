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

	    ScrollBar {
		orientation: Qt.Horizontal
		policy: ScrollBar.AlwaysOn
		anchors.bottom: parent.bottom
	    }

	    // Vertical ScrollBar for rows
	    ScrollBar {
		orientation: Qt.Vertical
		policy: ScrollBar.AlwaysOn
		anchors.right: parent.right
	    }

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
		    if (width <= 145) {
			return 145;
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
					showVehicle(customer.getVehicles().getVehicleByRow(row).getId());
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
				    onClicked: {
					setSelectedVehicle(customer.getVehicles().getVehicleByRow(row).getId());
					editVehicleDialog.open();
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
				    onClicked: {
					setSelectedVehicle(customer.getVehicles().getVehicleByRow(row).getId());
					removeVehicleDialog.open();
				    }
				}
			    }
			}
		    }
		}
	    }
	}
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
		id: editMarkInput
		background: Rectangle {
		    id: editMarkTextRect
		    color: "white"
		    radius: 10
		    width: 350
		    height: 30
		    border.color: "lightgray"
		}
		implicitWidth: editMarkTextRect.width
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Mark (" + customer.getVehicles().getVehicleById(selectedVehicleId).getMark() + ")"
	    }

	    Label {
		id: wrongEditMarkInput
		visible: false
		font.pixelSize: 10
		color: "red"
		text: "Mark should contain only letters!"
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
		text: "Year should contain only digits!"
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
		text: "VIN should contain 17 characters!"
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
		    if (editMarkInput.text !== "") {
			if (!valid.markIsValid(editMarkInput.text)) {
			    wrongEditMarkInput.visible = true;
			    isValid = false;
			} else {
			    wrongEditMarkInput.visible = false;
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
				if (dbController.updateVehicle(selectedVehicleId, editMarkInput.text, editModelInput.text, editYearInput.text, editVersionInput.text, editEngineInput.text, vehicleTypeModel.get(vehicleEditTypeComboBox.currentIndex).id, vehicleTypeModel.get(vehicleEditTypeComboBox.currentIndex).typeName, editVinInput.text, editRegistrationInput.text)) {
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

    Dialog {
	id: removeVehicleDialog
	anchors.centerIn: parent
	width: 300
	height: 150
	parent: Overlay.overlay
	focus: true
	modal: true
	title: ""
	Column {
	    spacing: 5
	    anchors.horizontalCenter: parent.horizontalCenter
	    Label {
		text: "This CAN NOT be undone!"
		font.pixelSize: 20
		color: "black"
		font.bold: true
	    }
	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter
		Button {
		    text: "Remove"
		    onClicked: {
			if (dbController.removeVehicle(selectedVehicleId)) {
			    customer.fetchVehicles(customer.getId());
			    removeVehicleDialog.close();
			}
		    }
		}
		Button {
		    text: "Cancel"
		    onClicked: {
			removeVehicleDialog.close();
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
	height: 630
	parent: Overlay.overlay
	focus: true
	modal: true
	title: "Add vehicle"

	Column {
	    id: addVehicleColumn
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
		font.pixelSize: 10
		color: "red"
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
		font.pixelSize: 10
		color: "red"
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
		validator: RegularExpressionValidator {
		    regularExpression: /^[0-9]*$/
		}
		wrapMode: "Wrap"
		font.pixelSize: 15
		placeholderText: "Year...                      "
	    }

	    Label {
		id: wrongYearInput
		visible: false
		font.pixelSize: 10
		color: "red"
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
		font.pixelSize: 10
		color: "red"
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
		font.pixelSize: 10
		color: "red"
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
		placeholderText: "VIN...                      "
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
		    if (!valid.markIsValid(markInput.text)) {
			wrongMarkInput.visible = true;
			isValid = false;
		    } else {
			wrongMarkInput.visible = false;
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
				if (dbController.addVehicle(customer.getId(), markInput.text, modelInput.text, yearInput.text, versionInput.text, engineInput.text, vehicleTypeModel.get(vehicleTypeComboBox.currentIndex).id, vehicleTypeModel.get(vehicleTypeComboBox.currentIndex).typeName, vinInput.text, registrationInput.text)) {
				    customer.fetchVehicles(customer.getId());
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
