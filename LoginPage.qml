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
	text: "Login to your account"
	font.pixelSize: 35
	font.bold: true
	font.family: "Open Sans"
    }

    Column {
	id: loginColumnId

	anchors.centerIn: parent
	spacing: 5

	TextField {
	    id: emailInput
	    font.pixelSize: 14
	    color: "black"
	    width: 300
	    height: 40
	    text: ""
	    wrapMode: "Wrap"
	    placeholderText: "Email"
	}

	TextField {
	    id: passwordInput
	    font.pixelSize: 14
	    echoMode: "Password"
	    color: "black"
	    text: ""
	    width: 300
	    height: 40
	    wrapMode: "Wrap"
	    placeholderText: "Password"
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
		dbController.fetchVehicleTypes();
		customer.fetchVehicles(customer.getId());
		notifModel.fetchNotifications(customer.getId());
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
			main.showRegister();
		    }
		}
	    }
	}
	Label {
	    id: forgotPasswordText
	    text: "forgot password?"
	    font.pixelSize: 12
	    color: "black"
	    font.underline: true
	    anchors.horizontalCenter: parent.horizontalCenter
	    MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		onClicked: {
		    changePasswordDialog.openDialog();
		}
	    }
	}
    }

    Connections {
	target: loginController
	function onSuccessfullyLogged() {
	    main.showMainView();
	}

	function onFailedLogin() {
	    wrongDataLabelId.visible = true;
	}
    }

    ChangePasswordDialog {
	id: changePasswordDialog
    }

    //    Dialog {
    // id: debugDialogForSql
    // width: 500
    // height: 500
    // Label {
    //     text: dbController.debug()
    //     font.pixelSize: 20
    //     color: "black"
    // }
    // standardButtons: Dialog.Ok | Dialog.Cancel
    //    }
}
