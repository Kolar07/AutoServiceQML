import QtQuick
import QtQuick.Controls 2

Item {

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
		height: 25
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
		height: 25
		color: "white"
		radius: 10
		border.color: "black"
	    }
	    wrapMode: "Wrap"
	    implicitWidth: passwordBackground.width
	    placeholderText: "Password                        "
	}

	Button {
	    id: loginButtonId
	    text: "Login"
	    anchors.horizontalCenter: loginColumnId.horizontalCenter
	    onClicked: {
		loginController.login(emailInput.text, passwordInput.text);
	    }
	}

	Label {
	    id: wrongDataLabelId
	    visible: false
	    text: "Wrong data!"
	    font.pixelSize: 10
	    color: "red"
	    anchors.horizontalCenter: parent.horizontalCenter
	}
    }

    Connections {
	target: loginController
	function onSuccessfullyLogged() {
	    viewLoader.source = "Main.qml";
	}
	function onFailedLogin() {
	    //viewLoader.source = "LoginPage.qml";
	    wrongDataLabelId.visible = true;
	}
    }
}
