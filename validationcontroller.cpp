#include "validationcontroller.h"

ValidationController::ValidationController() {}

bool ValidationController::markIsValid(QString mark) const
{
    static QRegularExpression markRegex("^[A-Za-z]+(?:[ -][A-Za-z]+)*$");

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

bool ValidationController::mileageIsValid(int mileage) const
{
    if(mileage>=0)
        return true;
    return false;
}

bool ValidationController::intervalKmIsValid(int intervalKm) const
{
    if(intervalKm >=0)
        return true;
    return false;
}

bool ValidationController::serviceDateIsValid(int day, int month, int year) const
{
    QDate date;
    if(date.isValid(year,month,day))
        return true;
    return false;
}

bool ValidationController::intervalTimeIsValid(int months) const
{
    if(months>=0)
        return true;
    else return false;
}

bool ValidationController::serviceIsValid(QString service) const
{
    if(service != "" && service.length()<=255)
        return true;
    return false;
}

bool ValidationController::oilIsValid(QString oil) const
{
    if(oil.length()<=255)
        return true;
    else return false;
}

bool ValidationController::oilFilterIsValid(QString oilFilter) const
{
    if(oilFilter.length() <= 255)
        return true;
    return false;
}

bool ValidationController::airFilterIsValid(QString airFilter) const
{
    if(airFilter.length()<=255)
        return true;
    return false;
}

bool ValidationController::cabinFilterIsValid(QString cabinFilter) const
{
    if(cabinFilter.length() <=255)
        return true;
    return false;
}

bool ValidationController::timingIsValid(QString timing) const
{
    if(timing.length() <=255)
        return true;
    return false;
}

bool ValidationController::customPartsIsValid(QString customParts) const
{
    if(customParts.length()<=255)
        return true;
    else return false;
}

bool ValidationController::noteIsValid(QString note) const
{
    if(note.length()<=255)
        return true;
    return false;
}
