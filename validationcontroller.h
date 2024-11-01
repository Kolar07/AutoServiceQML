#ifndef VALIDATIONCONTROLLER_H
#define VALIDATIONCONTROLLER_H

#include <QObject>
#include "vehicletype.h"
#include <QRegularExpression>

class ValidationController : public QObject
{
    Q_OBJECT
public:
    ValidationController();

   Q_INVOKABLE bool markIsValid(QString mark) const;
   Q_INVOKABLE bool modelIsValid(QString model) const;
   Q_INVOKABLE bool yearIsValid(int year) const;
   Q_INVOKABLE bool engineIsValid(QString engine) const;
   Q_INVOKABLE bool versionIsValid(QString version) const;
   Q_INVOKABLE bool vinIsValid(QString vin) const;
   Q_INVOKABLE bool regNumberIsValid(QString regNb) const;
   Q_INVOKABLE  bool typeIsValid(QString type)const;

};

#endif // VALIDATIONCONTROLLER_H
