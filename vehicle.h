#ifndef VEHICLE_H
#define VEHICLE_H

#include <QObject>
#include "service.h"
#include "notification.h"
#include "vehicletype.h"
#include <QDebug>

class Vehicle : public QObject
{
    Q_OBJECT
public:
    explicit Vehicle(QObject *parent = nullptr);
    Vehicle(int id, const VehicleType &type, const QString &mark, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber);
    Vehicle(const VehicleType &type, const QString &mark, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber);

    int getId() const;
    void setId(int newId);

    QString getMark() const;
    void setMark(const QString &newMark);

    QString getModel() const;
    void setModel(const QString &newModel);

    int getYear() const;
    void setYear(int newYear);

    QString getVersion() const;
    void setVersion(const QString &newVersion);

    QString getEngine() const;
    void setEngine(const QString &newEngine);

    QString getVin() const;
    void setVin(const QString &newVin);

    QString getRegistrationNumber() const;
    void setRegistrationNumber(const QString &newRegistrationNumber);

    void addService(std::shared_ptr<Service> &service);
    void removeService(int serviceId);


    QVector<std::shared_ptr<Service> > getServices() const;
    std::shared_ptr<Service> getServiceByNumber(int nb) const;
    void setServices(const QVector<std::shared_ptr<Service> > &newServices);

private:
    int id;
    VehicleType type;
    QString mark;
    QString model;
    int year;
    QString version;
    QString engine;
    QString vin;
    QString registrationNumber;
    QVector<std::shared_ptr<Service>> services;
    QVector<Notification> notifications;

signals:
};

#endif // VEHICLE_H
