import QtQuick
import QtQuick.Controls 2

Item {

    Image {
	id: logoId
	anchors.left: parent.left
	anchors.bottom: parent.bottom
	width: 180
	height: 100
	source: "qrc:/assets/logo.png"
    }

    Rectangle {
	id: tableViewId
	anchors.bottom: logoId.top
	anchors.left: parent.left
	anchors.leftMargin: 30
	anchors.top: parent.top
	anchors.topMargin: 30
	anchors.right: parent.right
	anchors.rightMargin: 30
	width: 700
	//height: 600
	color: "white"
	border.color: "black"

	Text {
	    anchors.centerIn: parent
	    text: "Table with vehicles"
	    color: "black"
	    font.pixelSize: 30
	}

	ComboBox {
	    model: vehicleTypeModel
	    textRole: "typeName"  // Wyświetla nazwę typu pojazdu
	    width: implicitWidth + 50
	    onCurrentIndexChanged: {
		console.log("Selected Vehicle Type:", vehicleTypeModel.get(currentIndex).typeName);
	    }
	}
    }

    //    Column {
    // id: buttonsColumn
    // spacing: 7
    // anchors.top: parent.top
    // anchors.right: parent.right
    // anchors.topMargin: 20
    // anchors.rightMargin: 20
    // anchors.left: tableViewId.right
    // anchors.bottom: parent.bottom
    // Rectangle {
    //     id: addVehicleButton
    //     color: "black"
    //     radius: 10
    //     width: 400
    //     height: 40
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     Text {
    // 	anchors.centerIn: parent
    // 	text: "Add vehicle"
    // 	color: "white"
    // 	font.pixelSize: 15
    //     }
    // }

    // Rectangle {
    //     id: removeVehicleButton
    //     color: "black"
    //     radius: 10
    //     width: 400
    //     height: 40
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     Text {
    // 	anchors.centerIn: parent
    // 	text: "Remove vehicle"
    // 	color: "white"
    // 	font.pixelSize: 15
    //     }
    // }

    // Rectangle {
    //     id: editVehicleButton
    //     color: "black"
    //     radius: 10
    //     width: 400
    //     height: 40
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     Text {
    // 	anchors.centerIn: parent
    // 	text: "Edit vehicle"
    // 	color: "white"
    // 	font.pixelSize: 15
    //     }
    // }
    //}
}
