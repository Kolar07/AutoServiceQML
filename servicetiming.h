#ifndef SERVICETIMING_H
#define SERVICETIMING_H

#include <QObject>
#include "maintenanceservice.h"

class ServiceTiming : public MaintenanceService
{
    Q_OBJECT
public:
    ServiceTiming();
    ServiceTiming(int _id, int _mileage,int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type, const QString _timing);
    ServiceTiming(int _mileage,int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type, const QString _timing);

    //void print() override;

    QString getTiming() const;
    void setTiming(const QString &newTiming);

private:
    QString timing;

signals:
};

#endif // SERVICETIMING_H
