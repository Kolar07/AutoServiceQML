#ifndef REPAIRSERVICE_H
#define REPAIRSERVICE_H

#include "service.h"
#include "maintenanceservice.h"
#include <QDebug>

class RepairService : public MaintenanceService
{
    Q_OBJECT
public:
    RepairService();
    RepairService(int _id, int _mileage, int _interval_km, QString date, int _interval_time, const QString &_service, const QString &_type, const QString _customParts, const QString &_note);
    RepairService(int _mileage,int _interval_km, QString date, int _interval_time, const QString &_service, const QString &_type,const QString _customParts, const QString &_note);


    Q_INVOKABLE QString getCustomParts() const;
    void setCustomParts(const QString &newParts);

private:
     QString customParts;
};

#endif // REPAIRSERVICE_H
