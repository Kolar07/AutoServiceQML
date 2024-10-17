#ifndef VEHICLETYPE_H
#define VEHICLETYPE_H

#include <QObject>

class VehicleType : public QObject
{
    Q_OBJECT
public:
    explicit VehicleType(QObject *parent = nullptr);

signals:
};

#endif // VEHICLETYPE_H
