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
    MaintenanceService(int _id, int _mileage,int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type);
    MaintenanceService(int _mileage,int _interval_km, QString date, QString _interval_time, const QString &_service, const QString &_type);
    virtual void print() override;

    int getInterval_km() const;
    void setInterval_km(int newInterval_km);

    QDate getInterval_time() const override;
    void setInterval_time(const QDate &newInterval_time);

    QString getService() const;
    void setService(const QString &newService);


private:
    int interval_km;
    QDate interval_time;
    QString service;

signals:
};

#endif // MAINTENANCESERVICE_H
