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
	anchors.bottom: loginColumnId.top
	anchors.bottomMargin: 10
	text: "Welcome! Please login to your account"
	font.pixelSize: 35
	font.bold: true
	font.family: "Comic Sans MS"
    }

    Column {
	id: loginColumnId

	anchors.centerIn: parent
	spacing: 5

	TextField {
	    id: emailInput
	    font.pixelSize: 14
	    //PlaceholderText: "email"
	    color: "black"
	    background: Rectangle {
		id: emailBackground
		width: 300
		height: 35
		color: "white"
		radius: 10
		border.color: "black"
	    }
	    wrapMode: "Wrap"
	    implicitWidth: emailBackground.width
	    placeholderText: "Email                              "
	}

	TextField {
	    id: passwordInput
	    font.pixelSize: 14
	    //PlaceholderText: "password"
	    echoMode: "Password"
	    color: "black"
	    background: Rectangle {
		id: passwordBackground
		width: 300
		height: 35
		color: "white"
		radius: 10
		border.color: "black"
	    }
	    wrapMode: "Wrap"
	    implicitWidth: passwordBackground.width
	    placeholderText: "Password                        "
	}

	Label {
	    id: wrongDataLabelId
	    visible: false
	    text: "Wrong data!"
	    font.pixelSize: 10
	    color: "red"
	    anchors.horizontalCenter: parent.horizontalCenter
	}

	Button {
	    id: loginButtonId
	    text: "Login"
	    anchors.horizontalCenter: loginColumnId.horizontalCenter
	    onClicked: {
		wrongDataLabelId.visible = false;
		loginController.login(emailInput.text, passwordInput.text);
	    }
	}

	Row {
	    anchors.topMargin: 10
	    anchors.horizontalCenter: loginColumnId.horizontalCenter
	    Label {
		id: noAccountLabelId
		text: "or create an account "
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
			viewLoader.source = "RegistrationPage.qml";
		    }
		}
	    }
	}
    }

    Connections {
	target: loginController
	function onSuccessfullyLogged() {
	    viewLoader.source = "MainViewPage.qml";
	}
	function onFailedLogin() {
	    //viewLoader.source = "LoginPage.qml";
	    wrongDataLabelId.visible = true;
	}
    }
}
