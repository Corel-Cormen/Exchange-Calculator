import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12

ApplicationWindow {
    id: window
    width: 720 /1.5
    height: 1080 /1.5
    visible: true
    title: qsTr("Currency Calculator")
    Universal.theme: Universal.Dark

    property variant nominal: []
    property variant nominalInValue: []
    property variant nominalOutValue: []
    property int indexInData: 0
    property int indexOutData: 0
    property bool flagToStart: true
    property variant appCoreData: [[]];

    Frame {
        id: frameMoney
        width: parent.width * 0.90
        height: parent.height * 0.3
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.05
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05

        Text {
            id: inputValue
            property bool enableSmallSize: false
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.10
            font.family: "Arial"
            font.pointSize: inputValue.enableSmallSize === false ? parent.height * 0.20 : parent.height * 0.15
            text: qsTr("0")
            color: "white"
        }

        Text {
            id: inputNominal
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.10
            anchors.right: parent.right
            font.family: "Arial"
            font.pointSize: inputValue.enableSmallSize === false ? parent.height * 0.20 : parent.height * 0.15
            color: "white"
        }

        Text {
            id: outputValue
            property bool enableSmallSize: false
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.10
            font.family: "Arial"
            font.pointSize: outputValue.enableSmallSize === false ? parent.height * 0.20 : parent.height * 0.15
            text: qsTr("0")
            color: "white"
        }

        Text {
            id: outputNominal
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.10
            anchors.right: parent.right
            font.family: "Arial"
            font.pointSize: outputValue.enableSmallSize === false ? parent.height * 0.20 : parent.height * 0.15
            color: "white"
        }

        Text {
            id: infoNominal
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            font.pointSize: parent.height * 0.05
            //text: "1 --- = ... ---"
            color: "white"
        }
    }

    ComboBox {
        id: inputNominalBox
        width: parent.width / 3
        anchors.top: frameMoney.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
        model: []
        onActivated: changeInputNominal(model[index])
    }

    ComboBox {
        id: outputNominalBox
        width: parent.width / 3
        anchors.top: frameMoney.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05
        model: []
        onActivated: changeOutputNominal(model[index])
    }

    Rectangle {
        id: frameButtons
        width: parent.width * 0.90
        height: parent.height * 0.50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
        color: window.color

        Row {
            width: parent.width
            height: parent.height / 5
            anchors.top: parent.top
            anchors.left: parent.left

            Button {
                id: button_Back
                width: parent.width / 3
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 0
                text: qsTr("<-")
                onPressed: Universal.Violet
                onClicked: buttonClick(this)
            }

            Button {
                id: button_CE
                width: parent.width / 3
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: button_Back.width
                text: qsTr("CE")
                onClicked: buttonClick(this)
            }
        }

        Row {
            width: parent.width
            height: parent.height / 5
            anchors.top: parent.top
            anchors.topMargin: button_Back.height
            anchors.left: parent.left

            Button {
                id: button_7
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: 0
                text: qsTr("7")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_8
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: button_Back.width
                text: qsTr("8")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_9
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: button_Back.width
                text: qsTr("9")
                onClicked: buttonClick(this)
            }
        }

        Row {
            width: parent.width
            height: parent.height / 5
            anchors.top: parent.top
            anchors.topMargin: button_CE.height*2
            anchors.left: parent.left

            Button {
                id: button_4
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: 0
                text: qsTr("4")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_5
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: button_Back.width
                text: qsTr("5")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_6
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: button_Back.width
                text: qsTr("6")
                onClicked: buttonClick(this)
            }
        }

        Row {
            width: parent.width
            height: parent.height / 5
            anchors.top: parent.top
            anchors.topMargin: button_CE.height*3
            anchors.left: parent.left

            Button {
                id: button_1
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: 0
                text: qsTr("1")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_2
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: button_Back.width
                text: qsTr("2")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_3
                width: parent.width / 3
                height: parent.height
                anchors.leftMargin: button_Back.width
                text: qsTr("3")
                onClicked: buttonClick(this)
            }
        }

        Row {
            width: parent.width
            height: parent.height / 5
            anchors.top: parent.top
            anchors.topMargin: button_CE.height*4
            anchors.right: parent.right

            Button {
                id: button_dot
                width: parent.width / 3
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 0
                text: qsTr(".")
                onClicked: buttonClick(this)
            }

            Button {
                id: button_0
                width: parent.width / 3
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: button_Back.width
                text: qsTr("0")
                onClicked: buttonClick(this)
            }
        }
    }

    Rectangle {
        id: noConnectionRec
        anchors.centerIn: parent
        width: parent.width * 0.70
        height: parent.height * 0.10
        color: "red"
        visible: true
        radius: 50
        Text {
            text: qsTr("Failed to connect")
            anchors.centerIn: parent
            fontSizeMode: Text.Fit
            font.pointSize: parent.height * 0.2
        }
        Text {
            text: qsTr("Tap to try connection")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            fontSizeMode: Text.Fit
        }

        MouseArea {
            anchors.fill: parent
            onPressed: appcore.onRequest();
        }
    }

    function buttonClick(button)
    {
        if(inputValue.text.length <= 14 && outputValue.text.length <= 14)
        {
            var dotPosition = inputValue.text.lastIndexOf('.');

            if(inputValue.text === "0")
                inputValue.text = "";

            if(button.text >= "0" && button.text <= "9")
            {
                if(dotPosition >= inputValue.text.length - 2 || dotPosition === -1)
                    inputValue.text += button.text;
            }
            else if(button.text === ".")
            {
                if(dotPosition === -1)
                    inputValue.text += ".";
            }
        }

        if(button.text === "CE")
            inputValue.text = "0";
        else if(button.text === "<-")
        {
            inputValue.text = inputValue.text.substring(0, inputValue.text.length-1);
            if(inputValue.text === "")
                inputValue.text = "0";
        }

        outputValue.text = calculateMoney();

        if(inputValue.text.length >= 9 || outputValue.text.length >= 9) {
            inputValue.enableSmallSize = true;
            outputValue.enableSmallSize = true;
        }
        else {
            inputValue.enableSmallSize = false;
            outputValue.enableSmallSize = false;
        }
    }

    function changeInputNominal(index) {
        inputNominal.text = "<i>" + index.substring(0, 3) + "</i>";
        indexInData = 0;
        while(index.substring(0, 3) !== appCoreData[indexInData][0])
            indexInData++;
        infoNominal.text = "1 " + index.substring(0, 3) + " = " + calculateCourse() + " " + appCoreData[indexOutData][0];
        outputValue.text = calculateMoney();
    }
    function changeOutputNominal(index) {
        outputNominal.text = "<i>" + index.substring(0, 3) + "</i>";
        indexOutData = 0;
        while(index.substring(0, 3) !== appCoreData[indexOutData][0])
            indexOutData++;
        infoNominal.text = infoNominal.text.substring(0, 8) + calculateCourse() + " " + appCoreData[indexOutData][0];
        outputValue.text = calculateMoney();
    }

    function calculateCourse(){
        if(appCoreData[indexInData][0] === "PLN") {
            return appCoreData[indexOutData][2];
        }
        else {
            var t1 = 1 / appCoreData[indexInData][2];
            var t2 = 1 / appCoreData[indexOutData][2];
            return (t2 / t1).toFixed(4);
        }
    }

    function calculateMoney() {
        var t1 = parseFloat(inputValue.text);
        var t2 = calculateCourse();
        return (t1*t2).toFixed(2);
    }

    Connections {
        target: appcore
        function onIsDataChanged() {
            console.log("onIsDataChanged");

            //let appCoreData = [[]];
            appCoreData[0] = [];
            appCoreData[0][0] = "PLN";
            appCoreData[0][1] = "polski złoty";
            appCoreData[0][2] = 1.0
            nominal[0] = appCoreData[0][0] + " " + appCoreData[0][1];
            for(var i = 1; i < appcore.getSizeExchange()+1; i++)
            {
                appCoreData[i] = [];
                appCoreData[i][0] = appcore.getDataExchangeSymbol(i-1);
                appCoreData[i][1] = appcore.getDataExchangeCurrency(i-1);
                appCoreData[i][2] = (appcore.getDataExchangeAverageExchange(i-1)).toFixed(4);

                nominal[i] = appCoreData[i][0] + " " + appCoreData[i][1];
            }
            nominal.sort();
            appCoreData.sort();

            console.log(appCoreData);
            inputNominalBox.model = nominal;
            outputNominalBox.model = nominal;

            if(flagToStart)
            {
                for(let i = 0; i < appcore.getSizeExchange()+1; i++)
                {
                    if(nominal[i] === "PLN polski złoty")
                    {
                        inputNominalBox.currentIndex = i;
                        changeInputNominal(nominal[i])
                        indexInData = i;
                    }
                    if(nominal[i] === "EUR euro Strefa Euro")
                    {
                        outputNominalBox.currentIndex = i;
                        changeOutputNominal(nominal[i]);
                        indexOutData = i;
                    }
                }

                if(appcore.getSizeExchange() === 0)
                    noConnectionRec.visible = true
                else
                    noConnectionRec.visible = false

                flagToStart = !flagToStart;
            }
        }
    }
}
