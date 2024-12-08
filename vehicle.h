#ifndef VEHICLE_H
#define VEHICLE_H

#include <QObject>
#include "service.h"
#include "notification.h"
#include "vehicletype.h"
#include <QDebug>
#include "servicemodel.h"
#include <QQmlEngine>

class Vehicle : public QObject
{
    Q_OBJECT
public:
    explicit Vehicle(QObject *parent = nullptr);
    Vehicle(int id, const VehicleType &type, const QString &brand,
            const QString &model, int year, const QString &version,
            const QString &engine, const QString &vin, const QString &registrationNumber);
    Vehicle(const VehicleType &type, const QString &brand,
            const QString &model, int year, const QString &version,
            const QString &engine, const QString &vin, const QString &registrationNumber);
    ~Vehicle();

    Q_INVOKABLE int getId() const;
    Q_INVOKABLE  QString getBrand() const;
    Q_INVOKABLE  QString getModel() const;
    Q_INVOKABLE int getYear() const;
    Q_INVOKABLE QString getVersion() const;
    Q_INVOKABLE QString getEngine() const;
    Q_INVOKABLE QString getVin() const;
    Q_INVOKABLE QString getRegistrationNumber() const;
    Q_INVOKABLE QString getTypeString() const;
    Q_INVOKABLE int getTypeInt() const;
    Q_INVOKABLE ServiceModel *getServices();

    void setId(int newId);
    void setBrand(const QString &newMark);
    void setModel(const QString &newModel);
    void setYear(int newYear); 
    void setVersion(const QString &newVersion);
    void setEngine(const QString &newEngine);
    void setVin(const QString &newVin);
    void setRegistrationNumber(const QString &newRegistrationNumber);
    void setType(const VehicleType &newType);

    void addService(std::shared_ptr<Service> &service);
    void setServices(ServiceModel *newServices);

signals:
    void fetchServices(int vehicleId);

public slots:
    void onFetchedServices(int vehicleId,QVector<std::shared_ptr<Service>> &services);

private:
    int id;
    VehicleType type;
    QString brand;
    QString model;
    int year;
    QString version;
    QString engine;
    QString vin;
    QString registrationNumber;
    ServiceModel *services;
};

#endif // VEHICLE_H
