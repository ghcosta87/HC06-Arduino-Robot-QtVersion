#include "ble_interface.h"

ble_interface::ble_interface(QObject *parent) : QObject(parent)
{
    socket = new QBluetoothSocket(QBluetoothServiceInfo::RfcommProtocol);
    //    agent = new QBluetoothDeviceDiscoveryAgent(this);
    // connect(socket, SIGNAL(deviceDiscovered(QBluetoothDeviceInfo)),
    //                this, SLOT(deviceDiscovered(QBluetoothDeviceInfo)));

    //    connect(&m_localDevice, &QBluetoothLocalDevice::hostModeStateChanged,
    //            this, &ConnectionHandler::hostModeChanged);

    //    connect(socket,SIGNAL(socket->connected()),
    //            this,SLOT(setConnectionStatus()));

    //    agent->start();
    //    socket->connected();
    //    bool teste=socket->ConnectedState;
    //    qDebug()<<"ANDROIDDEBUG > "<<teste;
}

void ble_interface::connectToDevice()
{
    static const QString serviceUuid(QStringLiteral("00001101-0000-1000-8000-00805F9B34FB"));//00001101-0000-1000-8000-00805F9B34FB
    socket->connectToService(QBluetoothAddress("98:DA:60:00:CA:C3"), QBluetoothUuid(serviceUuid), QIODevice::ReadWrite);
}

void ble_interface::writeToDevice(QString input)
{
    qDebug()<<"ANDROIDDEBUG:  ENVIANDO: "<<input;
    if(input.length()>1)input='f'+input+'e';
    QByteArray a=input.toLocal8Bit();
    const char *c = a.constData();
    socket->write(c);
    qDebug()<<"ANDROIDDEBUG:  ENVIANDO: "<<c;
}

QString ble_interface::readData(QString deviceToRecord)
{
    readBufferData();
    QStringList charReceived;

    if(deviceToRecord=="batt")
        charReceived=bufferData.split('v');

    if(deviceToRecord=="ble")
        charReceived=bufferData.split('b');

    qDebug()<<"ANDROIDDEBUG > "<<charReceived;

    if(charReceived.length()>1){
        qDebug()<<"ANDROIDDEBUG char > "<< charReceived[1];
        return charReceived[1];
    }

    return " ";
}

void ble_interface::deviceDiscovered(const QBluetoothDeviceInfo &device)
{
    qDebug()<<"ANDROIDDEBUG: there is a device available";
    deviceAvailable=true;
    qDebug() << "ANDROIDDEBUG: Found new device:" << device.name() << '(' << device.address().toString() << ')'
             << device.serviceUuids()<<"\n"<<device.serviceClasses()
             <<"\n"<<device.rssi()<<"\n"<<device.coreConfigurations();
}

void ble_interface::readBufferData()
{
    bufferData=socket->readAll();
}

void ble_interface::setConnectionStatus()
{
    qDebug()<<"ANDROIDEBUG CHECANDO ESTADO";

    if(socket->state()==QBluetoothSocket::ConnectedState){
        qDebug()<<"ANDROIDEBUG ESTADO > "<<socket->state();
        connectionState= socket->state()==QBluetoothSocket::ConnectedState;
    }else{
        qDebug()<<"ANDROIDDEBUG > NOT CONNECTED";
        connectionState=false;
    }
}

bool ble_interface::connectionStatus()
{
    setConnectionStatus();
    return connectionState;
}
