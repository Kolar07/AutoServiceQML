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
    MaintenanceService(int _id, int _mileage,int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type);
    MaintenanceService(int _mileage,int _interval_km, QString date, int _interval_time, const QString &_service, const QString &_type);
    virtual void print() override;

    int getInterval_km() const;
    void setInterval_km(int newInterval_km);

    int getInterval_time() const override;
    void setInterval_time(const int &newInterval_time);

    QString getService() const;
    void setService(const QString &newService);


private:
    int interval_km;
    int interval_time;
    QString service;

signals:
};

#endif // MAINTENANCESERVICE_H
