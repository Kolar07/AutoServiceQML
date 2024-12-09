#ifndef REPORTSGENERATOR_H
#define REPORTSGENERATOR_H

#include <QObject>
#include <QPrinter>
#include <QPainter>
#include <QDate>
#include <QDebug>
#include <QStandardPaths>
#include <QCoreApplication>
#include <QDir>
#include "customer.h"
#include "service.h"
#include "maintenanceservice.h"
#include "serviceoil.h"
#include "servicetiming.h"
#include "repairservice.h"

class ReportsGenerator : public QObject
{
    Q_OBJECT
public:
    explicit ReportsGenerator(QObject *parent = nullptr);

    Q_INVOKABLE void generateReport(Customer &customer, QString _path);
    Q_INVOKABLE void generateServicesCSV(QString _name, QString _surname, int _customerId, QVector<Vehicle*> _vehicles, QString _path, QString _fileName);
    Q_INVOKABLE void generateVehiclesCSV(QString _name, QString _surname, int _customerId, QVector<Vehicle*> _vehicles, QString _path, QString _fileName);
signals:
};

#endif // REPORTSGENERATOR_H
