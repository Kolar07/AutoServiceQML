import QtQuick
import QtQuick.Controls

Item {
    function openDialog() {
	changePasswordDialog.open();
    }

    Dialog {
	id: changePasswordDialog
	title: "Change password"
	anchors.centerIn: parent
	width: 400
	height: 400
	parent: Overlay.overlay
	focus: true
	modal: true
	Column {
	    id: changePasswordColumn

	    anchors.centerIn: parent
	    spacing: 5

	    TextField {
		id: emailInput
		font.pixelSize: 14
		color: "black"
		text: ""
		width: 300
		height: 40
		wrapMode: "Wrap"
		placeholderText: "Email"
	    }
	    Label {
		id: wrongEmailLabelId
		visible: false
		text: "Email cannot be empty"
		font.pixelSize: 10
		color: "red"
	    }

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
		text: "Name cannot be empty"
		font.pixelSize: 10
		color: "red"
	    }

	    TextField {
		id: surnameInput
		font.pixelSize: 14
		color: "black"
		width: 300
		height: 40
		wrapMode: "Wrap"
		placeholderText: "Surname"
	    }

	    Label {
		id: wrongSurnameLabelId
		visible: false
		text: "Surname cannot be empty"
		font.pixelSize: 10
		color: "red"
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
		placeholderText: "New password"
	    }
	    TextField {
		id: repeatPasswordInput
		font.pixelSize: 14
		//PlaceholderText: "password"
		echoMode: "Password"
		color: "black"
		text: ""
		width: 300
		height: 40
		wrapMode: "Wrap"
		placeholderText: "Repeat password"
	    }
	    Label {
		id: wrongRepeatPasswordLabelId
		visible: false
		text: "Passwords are not the same"
		font.pixelSize: 10
		color: "red"
	    }

	    Label {
		id: wrongDataLabelId
		visible: false
		text: "Provide correct name, surname and email to change password!"
		font.pixelSize: 10
		color: "red"
	    }
	    Row {
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter
		Button {
		    text: "Change password"
		    onClicked: {
			let isValid = true;
			if (emailInput.text === "") {
			    isValid = false;
			    wrongEmailLabelId.visible = true;
			} else {
			    wrongEmailLabelId.visible = false;
			}
			if (nameInput.text === "") {
			    isValid = false;
			    wrongNameLabelId.visible = true;
			} else {
			    wrongNameLabelId.visible = false;
			}
			if (surnameInput.text === "") {
			    isValid = false;
			    wrongSurnameLabelId.visible = true;
			} else {
			    wrongSurnameLabelId.visible = false;
			}
			if (!valid.passwordIsValid(passwordInput.text)) {
			    isValid = false;
			    wrongSurnameLabelId.visible = true;
			} else {
			    wrongSurnameLabelId.visible = false;
			}
			if (!valid.passwordsMatch(passwordInput.text, repeatPasswordInput.text)) {
			    isValid = false;
			    wrongRepeatPasswordLabelId.visible = true;
			} else {
			    wrongRepeatPasswordLabelId.visible = false;
			}
			if (isValid) {
			    if (dbController.changeCustomerPassword(emailInput.text, nameInput.text, surnameInput.text, passwordInput.text)) {
				wrongDataLabelId.visible = false;
				changePasswordDialog.close();
				successDialog.openDialog();
			    } else {
				console.log("valid: " + isValid);
				wrongDataLabelId.visible = true;
			    }
			}
		    }
		}

		Button {
		    text: "Cancel"
		    onClicked: {
			changePasswordDialog.close();
		    }
		}
	    }
	}
    }
    SuccessDialog {
	id: successDialog
    }
}
