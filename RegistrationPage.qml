import QtQuick
import QtQuick.Controls 2

Item {
    Image {
	id: logoId
	anchors.left: parent.left
	anchors.top: parent.top
	width: 300
	height: 200
	source: "qrc:/assets/logo.png"
    }

    Label {
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.bottom: registerColumnId.top
	anchors.bottomMargin: 10
	text: "Create an account"
	font.pixelSize: 35
	font.bold: true
	font.family: "Open Sans"
    }

    Column {
	id: registerColumnId
	anchors.centerIn: parent
	spacing: 5

	TextField {
	    id: nameInput
	    font.pixelSize: 14
	    color: "black"
	    width: 300
	    height: 40
	    wrapMode: "Wrap"
	    placeholderText: "Name"
	}

	Label {
	    id: wrongNameLabelId
	    visible: false
	    text: "Name cannot be empty and should contain only letters"
	    font.pixelSize: 10
	    color: "red"
	}

	TextField {
	    id: surnameInput
	    font.pixelSize: 14
	    color: "black"
	    wrapMode: "Wrap"
	    width: 300
	    height: 40
	    placeholderText: "Surname"
	}

	Label {
	    id: wrongSurnameLabelId
	    visible: false
	    text: "Surname cannot be empty and should contain only letters"
	    font.pixelSize: 10
	    color: "red"
	}

	TextField {
	    id: emailInput
	    font.pixelSize: 14
	    color: "black"
	    wrapMode: "Wrap"
	    placeholderText: "Email"
	    width: 300
	    height: 40
	}

	Label {
	    id: wrongEmailLabelId
	    visible: false
	    text: "Wrong email format"
	    font.pixelSize: 10
	    color: "red"
	}

	TextField {
	    id: passwordInput
	    font.pixelSize: 14
	    echoMode: "Password"
	    color: "black"
	    wrapMode: "Wrap"
	    placeholderText: "Password"
	    width: 300
	    height: 40
	}

	Label {
	    id: wrongPasswordLabelId
	    visible: false
	    text: "Password should be at least 8 letters long"
	    font.pixelSize: 10
	    color: "red"
	}

	TextField {
	    id: passwordRepeatInput
	    font.pixelSize: 14
	    echoMode: "Password"
	    color: "black"
	    wrapMode: "Wrap"
	    placeholderText: "Repeat password"
	    width: 300
	    height: 40
	}

	Label {
	    id: wrongRepeatPasswordLabelId
	    visible: false
	    text: "Passwords are not the same"
	    font.pixelSize: 10
	    color: "red"
	}

	Button {
	    id: registerButtonId
	    text: "Register"
	    anchors.horizontalCenter: registerColumnId.horizontalCenter
	    onClicked: {
		wrongNameLabelId.visible = false;
		wrongSurnameLabelId.visible = false;
		wrongEmailLabelId.visible = false;
		wrongPasswordLabelId.visible = false;
		wrongRepeatPasswordLabelId.visible = false;
		registerController.registerCustomer(nameInput.text, surnameInput.text, emailInput.text, passwordInput.text, passwordRepeatInput.text);
	    }
	}

	Row {
	    anchors.topMargin: 10
	    anchors.horizontalCenter: registerColumnId.horizontalCenter
	    Label {
		id: noAccountLabelId
		text: "or login "
		font.pixelSize: 15
		color: "black"
	    }

	    Label {
		id: registerHereText
		text: "HERE"
		font.pixelSize: 20
		color: "black"
		font.bold: true
		anchors.baseline: noAccountLabelId.baseline
		font.underline: true
		MouseArea {
		    anchors.fill: parent
		    cursorShape: Qt.PointingHandCursor
		    onClicked: {
			main.showLogin();
		    }
		}
	    }
	}
    }

    Connections {
	target: registerController
	function onRegistrationSuccess() {
	    main.showLogin();
	}
	function onRegistrationFailedName() {
	    wrongNameLabelId.visible = true;
	}
	function onRegistrationFailedSurname() {
	    wrongSurnameLabelId.visible = true;
	}
	function onRegistrationFailedEmail() {
	    wrongEmailLabelId.visible = true;
	}
	function onRegistrationFailedPassword() {
	    wrongPasswordLabelId.visible = true;
	}
	function onRegistrationFailedRepeatPassword() {
	    wrongRepeatPasswordLabelId.visible = true;
	}
    }
}
