#ifndef VEHICLE_H
#define VEHICLE_H

#include <QObject>
#include "service.h"
#include "notification.h"
#include "vehicletype.h"
#include <QDebug>
#include "servicemodel.h"

class Vehicle : public QObject
{
    Q_OBJECT
public:
    explicit Vehicle(QObject *parent = nullptr);
    Vehicle(int id, const VehicleType &type, const QString &mark, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber);
    Vehicle(const VehicleType &type, const QString &mark, const QString &model, int year, const QString &version, const QString &engine, const QString &vin, const QString &registrationNumber);
    ~Vehicle();
    Q_INVOKABLE int getId() const;
    void setId(int newId);

  Q_INVOKABLE  QString getMark() const;
    void setMark(const QString &newMark);

  Q_INVOKABLE  QString getModel() const;
    void setModel(const QString &newModel);

   Q_INVOKABLE int getYear() const;
    void setYear(int newYear);

   Q_INVOKABLE QString getVersion() const;
    void setVersion(const QString &newVersion);

   Q_INVOKABLE QString getEngine() const;
    void setEngine(const QString &newEngine);

   Q_INVOKABLE QString getVin() const;
    void setVin(const QString &newVin);

   Q_INVOKABLE QString getRegistrationNumber() const;
    void setRegistrationNumber(const QString &newRegistrationNumber);

    void addService(std::shared_ptr<Service> &service);
    void removeService(int serviceId);


    //QVector<std::shared_ptr<Service> > getServices() const;
    //std::shared_ptr<Service> getServiceByNumber(int nb) const;
    //void setServices(const QVector<std::shared_ptr<Service> > &newServices);

    VehicleType getType() const;
    Q_INVOKABLE QString getTypeString() const;
    Q_INVOKABLE int getTypeInt() const;
    void setType(const VehicleType &newType);

    Q_INVOKABLE ServiceModel *getServices();
    void setServices(ServiceModel *newServices);

 signals:
    void fetchServices(int id);

 public slots:
    void onFetchedServices(int vehicleId,QVector<std::shared_ptr<Service>> services);

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
    //QVector<std::shared_ptr<Service>> services;
    ServiceModel *services;
    QVector<Notification> notifications;

signals:
};

#endif // VEHICLE_H
