#include "vehiclemodel.h"

VehicleModel::VehicleModel(QObject *parent) : QAbstractTableModel(parent) {}

VehicleModel::VehicleModel(VehicleModel &&other) noexcept
    : QAbstractTableModel(other.parent()),
    vehicles(std::move(other.vehicles)),
    selected(std::move(other.selected)) {}

VehicleModel &VehicleModel::operator=(VehicleModel &&other) noexcept {
    if (this == &other)
        return *this;

    vehicles = std::move(other.vehicles);
    selected = std::move(other.selected);
    return *this;
}

int VehicleModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return vehicles.size();
}

int VehicleModel::columnCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return 10;
}

QVariant VehicleModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= vehicles.size())
        return QVariant();

    const Vehicle *vehicle = vehicles.at(index.row());
    switch (role) {
    case IdRole : return vehicle->getId();
    case TypeRole: return vehicle->getType().getTypeName();
    case MarkRole: return vehicle->getMark();
    case ModelRole: return vehicle->getModel();
    case YearRole: return vehicle->getYear();
    case VersionRole: return vehicle->getVersion();
    case EngineRole: return vehicle->getEngine();
    case VinRole: return vehicle->getVin();
    case RegNumberRole: return vehicle->getRegistrationNumber();
    case SelectedRole: return selected.at(index.row());
    default: return QVariant();
    }
}

QHash<int, QByteArray> VehicleModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles[IdRole] = "id";
    roles[TypeRole] = "type";
    roles[MarkRole] = "mark";
    roles[ModelRole] = "model";
    roles[YearRole] = "year";
    roles[VersionRole] = "version";
    roles[EngineRole] = "engine";
    roles[VinRole] = "vin";
    roles[RegNumberRole] = "regNumber";
    roles[SelectedRole] = "selected";
    return roles;
}

void VehicleModel::setData(QVector<Vehicle*> &_vehicles) {
    beginResetModel();
    vehicles = _vehicles;
    selected.resize(vehicles.size(), false);
    endResetModel();
}

void VehicleModel::toggleSelection(int index) {
    if (index < 0 || index >= selected.size())
        return;

    selected[index] = !selected[index];
    emit dataChanged(createIndex(index, 0), createIndex(index,0), {SelectedRole});
}

QVector<Vehicle*> VehicleModel::getSelectedVehicles() const {
    QVector<Vehicle*> selectedVehicles;
    for (int i = 0; i < selected.size(); ++i) {
        if (selected[i]) {
            selectedVehicles.append(vehicles[i]);
        }
    }
    return selectedVehicles;
}

QVector<Vehicle *> VehicleModel::getVehicles() const
{
    return vehicles;
}
