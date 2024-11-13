#ifndef VALIDATIONCONTROLLER_H
#define VALIDATIONCONTROLLER_H

#include <QObject>
#include "vehicletype.h"
#include <QRegularExpression>
#include <QDate>

class ValidationController : public QObject
{
    Q_OBJECT
public:
    ValidationController();


    //VEHICLE
   Q_INVOKABLE bool markIsValid(QString mark) const;
   Q_INVOKABLE bool modelIsValid(QString model) const;
   Q_INVOKABLE bool yearIsValid(int year) const;
   Q_INVOKABLE bool engineIsValid(QString engine) const;
   Q_INVOKABLE bool versionIsValid(QString version) const;
   Q_INVOKABLE bool vinIsValid(QString vin) const;
   Q_INVOKABLE bool regNumberIsValid(QString regNb) const;
   Q_INVOKABLE  bool typeIsValid(QString type)const;

   //SERVICE
   Q_INVOKABLE bool mileageIsValid(int mileage) const;
   Q_INVOKABLE bool intervalKmIsValid(int intervalKm) const;
   Q_INVOKABLE bool serviceDateIsValid(int day,int month,int year) const;
   Q_INVOKABLE bool intervalTimeIsValid(int months) const;
   Q_INVOKABLE bool serviceIsValid(QString service) const;
   Q_INVOKABLE bool oilIsValid(QString oil) const;
   Q_INVOKABLE bool oilFilterIsValid(QString oilFilter) const;
   Q_INVOKABLE bool airFilterIsValid(QString airFilter) const;
   Q_INVOKABLE bool cabinFilterIsValid(QString cabinFilter) const;
   Q_INVOKABLE bool timingIsValid(QString timing) const;
   Q_INVOKABLE bool customPartsIsValid(QString customParts) const;

};

#endif // VALIDATIONCONTROLLER_H
