#include "serviceoil.h"

ServiceOil::ServiceOil()
{}

ServiceOil::ServiceOil(int _id, int _mileage, int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type, const QString _oil, const QString _oilFilter, const QString _airFilter, const QString _cabinFilter)
    : MaintenanceService(_id,_mileage,_interval_km,date,_interval_time,_service,_type),
    oil(_oil),
    oilFilter(_oilFilter),
    airFilter(_airFilter),
    cabinFilter(_cabinFilter)
{

}

ServiceOil::ServiceOil(int _mileage, int _interval_km,QString date,  QString _interval_time, const QString &_service, const QString &_type, const QString _oil, const QString _oilFilter, const QString _airFilter, const QString _cabinFilter)
    : MaintenanceService(_mileage,_interval_km,date,_interval_time,_service,_type),
    oil(_oil),
    oilFilter(_oilFilter),
    airFilter(_airFilter),
    cabinFilter(_cabinFilter){}

QString ServiceOil::getOil() const
{
    return oil;
}

void ServiceOil::setOil(const QString &newOil)
{
    oil = newOil;
}

QString ServiceOil::getOilFilter() const
{
    return oilFilter;
}

void ServiceOil::setOilFilter(const QString &newOilFilter)
{
    oilFilter = newOilFilter;
}

QString ServiceOil::getAirFilter() const
{
    return airFilter;
}

void ServiceOil::setAirFilter(const QString &newAirFilter)
{
    airFilter = newAirFilter;
}

QString ServiceOil::getCabinFilter() const
{
    return cabinFilter;
}

void ServiceOil::setCabinFilter(const QString &newCabinFIlter)
{
    cabinFilter = newCabinFIlter;
}

