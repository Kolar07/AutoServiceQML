import QtQuick
import QtQuick.Controls 2

ApplicationWindow {
    visible: true
    width: 1280
    height: 720

    Loader {
	id: viewLoader
	anchors.fill: parent
	source: "LoginPage.qml"
    }
}
