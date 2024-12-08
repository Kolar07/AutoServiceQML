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

    void generateReport(Customer &customer, QString _path);
    void generateServicesCSV(Customer &customer, QString _path);
    void generateVehiclesCSV(Customer &customer, QString _path);
signals:
};

#endif // REPORTSGENERATOR_H
