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

int MaintenanceService::getInterval_km() const
{
    return interval_km;
}

void MaintenanceService::setInterval_km(int newInterval_km)
{
    interval_km = newInterval_km;
}

QDate MaintenanceService::getInterval_time() const
{
    return interval_time;
}

void MaintenanceService::setInterval_time(const QDate &newInterval_time)
{
    interval_time = newInterval_time;
}

QString MaintenanceService::getService() const
{
    return service;
}

void MaintenanceService::setService(const QString &newService)
{
    service = newService;
}
