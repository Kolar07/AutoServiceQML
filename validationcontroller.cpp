#include "validationcontroller.h"

ValidationController::ValidationController() {}

bool ValidationController::markIsValid(QString mark) const
{
    static QRegularExpression markRegex("^[A-Za-z]+$");

    if(mark == "" || !markRegex.match(mark).hasMatch())
        return false;
    return true;
}

bool ValidationController::modelIsValid(QString model) const {
    if(model == "")
        return false;
     return true;
}

bool ValidationController::yearIsValid(int year) const
{
    if(year>=1900 && year <=2025)
        return true;
    return false;
}

bool ValidationController::engineIsValid(QString engine) const
{
    if(engine != "")
        return true;
    return false;
}

bool ValidationController::versionIsValid(QString version) const
{
    if(version != "")
        return true;
    return false;
}

bool ValidationController::vinIsValid(QString vin) const
{
    static QRegularExpression vinRegex("^[A-HJ-NPR-Z0-9]{17}$");
    if(vin!="" && vinRegex.match(vin).hasMatch())
        return true;
    return false;
}

bool ValidationController::regNumberIsValid(QString regNb) const
{
    if(regNb!="")
        return true;
    return false;
}

bool ValidationController::typeIsValid(QString type) const
{
    if(type != "" && type.size() <50)
        return true;
    return false;
}
