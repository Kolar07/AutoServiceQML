#ifndef VEHICLE_H
#define VEHICLE_H

#include <QObject>

class Vehicle : public QObject
{
    Q_OBJECT
public:
    explicit Vehicle(QObject *parent = nullptr);

private:
    QString mark;
    QString model;
    int year;
    QString version;
    QString engine;
    QString vin;
    QString registrationNumber;

signals:
};

#endif // VEHICLE_H
