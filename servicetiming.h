#ifndef SERVICETIMING_H
#define SERVICETIMING_H

#include <QObject>
#include "maintenanceservice.h"

class ServiceTiming : public MaintenanceService
{
    Q_OBJECT
public:
    ServiceTiming();
    ServiceTiming(int _id, int _mileage,int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _timing, const QString &_note);
    ServiceTiming(int _mileage,int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _timing,const QString &_note);

    //void print() override;

    Q_INVOKABLE QString getTiming() const;
    void setTiming(const QString &newTiming);

private:
    QString timing;

signals:
};

#endif // SERVICETIMING_H
