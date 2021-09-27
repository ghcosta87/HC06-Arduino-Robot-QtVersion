#ifndef BLE_INTERFACE_H
#define BLE_INTERFACE_H


#include <QObject>
#include <iostream>
#include <string>
#include <QDebug>
#include <QString>

#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothSocket>
#include <QBluetoothLocalDevice>

class ble_interface : public QObject
{
    Q_OBJECT
public:
    explicit ble_interface(QObject *parent =nullptr);
    Q_INVOKABLE void connectToDevice();
    Q_INVOKABLE void writeToDevice(QString input);
    Q_INVOKABLE QString readData(QString deviceToRecord);
    Q_INVOKABLE bool connectionStatus();

//    Q_INVOKABLE bool checkAvailableDevices();
private slots:
    void deviceDiscovered(const QBluetoothDeviceInfo &device);

private:
    void setConnectionStatus();
    void readBufferData();
    QString bufferData;
    bool connectionState=false;
    QBluetoothDeviceDiscoveryAgent *agent;
    QBluetoothSocket *socket;
    bool deviceAvailable=false;
};

#endif // BLE_INTERFACE_H
