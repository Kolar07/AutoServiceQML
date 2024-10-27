#ifndef REPAIRSERVICE_H
#define REPAIRSERVICE_H

#include "service.h"
#include "maintenanceservice.h"

class RepairService : public MaintenanceService
{
public:
    RepairService();
    RepairService(int _id, int _mileage,int _interval_km,QString date, QString _interval_time, const QString &_service, const QString &_type);
    RepairService(int _mileage,int _interval_km, QString date, QString _interval_time, const QString &_service, const QString &_type);

   // void print() override;
    QString parts;
};

#endif // REPAIRSERVICE_H
