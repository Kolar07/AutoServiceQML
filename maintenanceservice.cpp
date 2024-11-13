#include "maintenanceservice.h"

MaintenanceService::MaintenanceService()
{}

MaintenanceService::MaintenanceService(int _id, int _mileage, int _interval_km, QString date, const int _interval_time, const QString &_service, const QString &_type) :Service(_id,_mileage,_type,date), interval_km(_interval_km),
    service(_service), interval_time(_interval_time)
{

}

MaintenanceService::MaintenanceService(int _mileage, int _interval_km, QString date, const int _interval_time, const QString &_service, const QString &_type)
    :Service(_mileage,_type,date), interval_km(_interval_km),
    service(_service),interval_time(_interval_time) {
}

void MaintenanceService::print()
{
    qDebug()<<"Service: "<<service<<" km interval: "<<interval_km<< " interval time: "<<interval_time<<" ";
}

int MaintenanceService::getInterval_km() const
{
    return interval_km;
}

void MaintenanceService::setInterval_km(int newInterval_km)
{
    interval_km = newInterval_km;
}

int MaintenanceService::getInterval_time() const
{
    return interval_time;
}

void MaintenanceService::setInterval_time(const int &newInterval_time)
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


