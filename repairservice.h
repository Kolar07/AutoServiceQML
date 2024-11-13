#ifndef REPAIRSERVICE_H
#define REPAIRSERVICE_H

#include "service.h"
#include "maintenanceservice.h"
#include <QDebug>

class RepairService : public MaintenanceService
{
public:
    RepairService();
    RepairService(int _id, int _mileage, int _interval_km, QString date, int _interval_time, const QString &_service, const QString &_type, const QString _customParts);
    RepairService(int _mileage,int _interval_km, QString date, int _interval_time, const QString &_service, const QString &_type,const QString _customParts);


    QString getCustomParts() const;
    void setCustomParts(const QString &newParts);

private:
     QString customParts;
};

#endif // REPAIRSERVICE_H
