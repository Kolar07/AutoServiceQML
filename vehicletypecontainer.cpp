#include "vehicletypecontainer.h"

VehicleTypeContainer::VehicleTypeContainer(QObject *parent): QAbstractTableModel(parent) {}

void VehicleTypeContainer::setVehicleTypes(const QVector<QPair<int, QString> > &vehicleTypes)
{
    beginResetModel();
    types = vehicleTypes;
    endResetModel();
}

int VehicleTypeContainer::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return types.size();
}

int VehicleTypeContainer::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1;
}

QVariant VehicleTypeContainer::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= types.size())
        return QVariant();

    const QPair<int, QString> &vehicleType = types.at(index.row());

    if (role == IdRole)
        return vehicleType.first;
    else if (role == TypeNameRole)
        return vehicleType.second;

    return QVariant();
}

QVariantMap VehicleTypeContainer::get(int row) const
{
    QVariantMap vehicleTypeData;
    if (row < 0 || row >= types.size()) {
        return vehicleTypeData;
    }

    const QPair<int, QString> &vehicleType = types.at(row);
    vehicleTypeData["id"] = vehicleType.first;
    vehicleTypeData["typeName"] = vehicleType.second;

    return vehicleTypeData;
}

QHash<int, QByteArray> VehicleTypeContainer::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TypeNameRole] = "typeName";
    return roles;
}

void VehicleTypeContainer::onVehicleTypesFetched(QVector<QPair<int, QString> > vehicleTypes)
{
    beginResetModel();
    setVehicleTypes(vehicleTypes);
    endResetModel();
}
