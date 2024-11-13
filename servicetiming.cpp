#include "servicetiming.h"

ServiceTiming::ServiceTiming()
{}

ServiceTiming::ServiceTiming(int _id, int _mileage, int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _timing)
    : MaintenanceService(_id,_mileage,_interval_km,date,_interval_time,_service,_type), timing(_timing)
{}

ServiceTiming::ServiceTiming(int _mileage, int _interval_km, QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _timing)
: MaintenanceService(_mileage,_interval_km,date,_interval_time,_service,_type), timing(_timing){}

QString ServiceTiming::getTiming() const
{
    return timing;
}

void ServiceTiming::setTiming(const QString &newTiming)
{
    timing = newTiming;
}
