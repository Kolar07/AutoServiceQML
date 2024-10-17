#ifndef MAINTENANCESERVICE_H
#define MAINTENANCESERVICE_H

#include <QObject>
#include "service.h"
#include <QDate>
#include <QDebug>


class MaintenanceService : public Service
{
    Q_OBJECT
public:
    MaintenanceService();
    MaintenanceService(int _id, int _mileage,int _interval_km, const QDate &_interval_time, const QString &_service, const QString &_type);
    virtual void print();

private:
    int interval_km;
    QDate interval_time;
    QString service;

signals:
};

#endif // MAINTENANCESERVICE_H