#ifndef VEHICLETYPE_H
#define VEHICLETYPE_H

#include <QObject>
#include <QMap>
#include <QVariant>

class VehicleType : public QObject
{
    Q_OBJECT
public:
    explicit VehicleType(QObject *parent = nullptr);
    VehicleType(int _id, QString _typeName);
    VehicleType(const VehicleType &other);
    bool operator==(const VehicleType &other);

    int getId() const;
    void setId(int newId);

    QString getTypeName() const;
    void setTypeName(const QString &newTypeName);

    void setProperties(QVariantMap vehicleTypeData);

    void print() const;

private:
    int id;
    QString typeName;

signals:
};

#endif // VEHICLETYPE_H


//
