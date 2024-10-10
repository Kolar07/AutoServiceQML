import QtQuick
import QtQuick.Controls

Item {
    property double itemWidth: 200
    property double itemHeight: 100
    property string rectColor: "black"
    property double pixelSize: 13
    property string vehicleId: "XXX"
    property string vehicleModel: "XXX"
    property string vehicleNextService: "0"

    Flickable {
	width: itemWidth
	height: itemHeight
	clip: true
	contentWidth: itemId.width
	contentHeight: itemId.height

	Item {
	    id: itemId

	    width: notifRect.width
	    height: textColumn.height

	    Rectangle {
		id: notifRect
		color: rectColor
		width: textColumn.width
		height: textColumn.height

		Column {
		    id: textColumn
		    padding: 5
		    anchors.left: parent.left
		    anchors.top: parent.top
		    anchors.topMargin: 1

		    Row {
			id: idRow
			padding: 3
			Text {
			    id: idText
			    text: "ID: "
			    font.bold: true
			    font.pixelSize: pixelSize
			}
			Text {
			    id: vehicleIdText
			    text: vehicleId
			    font.bold: true
			    font.pixelSize: pixelSize
			}
		    }

		    Row {
			id: modelRow
			padding: 3
			Text {
			    id: modelText
			    text: "Model: "
			    font.bold: true
			    font.pixelSize: pixelSize
			}
			Text {
			    id: vehicleModelText
			    text: vehicleModel
			    font.bold: true
			    font.pixelSize: pixelSize
			}
		    }

		    Row {
			id: dateRow
			padding: 3
			Text {
			    id: dateText
			    text: "Next service in: "
			    font.bold: true
			    font.pixelSize: pixelSize
			}
			Text {
			    id: vehicleNextServiceText
			    text: vehicleNextService + " days"
			    font.bold: true
			    font.pixelSize: pixelSize
			}
		    }

		    Row {
			id: additionalRow
			Text {
			    text: "Additional Info: This is wider than the visible area."
			    font.pixelSize: pixelSize
			}
		    }
		    Repeater {
			model: 10
			Row {
			    Text {
				text: "Extra Info: " + (index + 1)
				font.pixelSize: pixelSize
			    }
			}
		    }
		}
	    }
	}
	ScrollBar.vertical: ScrollBar {
	    policy: ScrollBar.AsNeeded
	}
	ScrollBar.horizontal: ScrollBar {
	    policy: ScrollBar.AsNeeded
	}
    }
}
