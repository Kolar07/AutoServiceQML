#ifndef MAINTENANCESERVICE_H
#define MAINTENANCESERVICE_H

#include <QObject>
#include "service.h"
#include <QDate>
#include <QDebug>


class MaintenanceService : public Service
{
    Q_OBJECT
public:
    MaintenanceService();
    MaintenanceService(int _id, int _mileage,int _interval_km,QString date,  int _interval_time, const QString &_service, const QString &_type, const QString &_note);
    MaintenanceService(int _mileage,int _interval_km, QString date, int _interval_time, const QString &_service, const QString &_type, const QString &_note);
    virtual void print() override;

    Q_INVOKABLE int getInterval_km() const;
    void setInterval_km(int newInterval_km);

    Q_INVOKABLE int getInterval_time() const override;
    void setInterval_time(const int &newInterval_time);

    Q_INVOKABLE QString getService() const;
    void setService(const QString &newService);


    Q_INVOKABLE QString getNote() const;
    void setNote(const QString &newNote);

private:
    int interval_km;
    int interval_time;
    QString service;
    QString note;

signals:
};

#endif // MAINTENANCESERVICE_H
