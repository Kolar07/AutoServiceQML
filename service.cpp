#include "service.h"

Service::Service(QObject *parent)
    : QObject{parent}
{}

Service::Service(int _id, int _milleage, QString _type) : id(_id),
    milleage(_milleage), type(_type)
{}
