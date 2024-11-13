#ifndef SERVICEOIL_H
#define SERVICEOIL_H

#include <QObject>
#include "maintenanceservice.h"

class ServiceOil : public MaintenanceService
{
    Q_OBJECT
public:
     ServiceOil();
    ServiceOil(int _id, int _mileage,int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _oil, const QString _oilFilterconst, QString _airFilter, const QString _cabinFilter);
    ServiceOil(int _mileage,int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString _oil, const QString _oilFilter, QString _airFilter, const QString _cabinFilter);

    //oid print() override;

    QString getOil() const;
    void setOil(const QString &newOil);

    QString getOilFilter() const;
    void setOilFilter(const QString &newOilFilter);

    QString getAirFilter() const;
    void setAirFilter(const QString &newAirFilter);

    QString getCabinFilter() const;
    void setCabinFilter(const QString &newCabinFIlter);

private:
     QString oil;
     QString oilFilter;
     QString airFilter;
     QString cabinFilter;


signals:
};

#endif // SERVICEOIL_H
