#include "maintenanceservice.h"

MaintenanceService::MaintenanceService()
{}

MaintenanceService::MaintenanceService(int _id, int _mileage,int _interval_km, const QDate &_interval_time, const QString &_service, const QString &_type) :Service(_id,_mileage,_type), interval_km(_interval_km),
    interval_time(_interval_time),
    service(_service)
{}

void MaintenanceService::print()
{
    qDebug()<<"Service: "<<service<<" km interval: "<<interval_km<< " interval time: "<<interval_time.toString()<<" ";
}
