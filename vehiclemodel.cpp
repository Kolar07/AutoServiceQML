#include "vehiclemodel.h"

VehicleModel::VehicleModel(QObject *parent) : QAbstractTableModel(parent) {}

VehicleModel::VehicleModel(VehicleModel &&other) noexcept
    : QAbstractTableModel(other.parent()),
    vehicles(std::move(other.vehicles)),
    selected(std::move(other.selected)) {}

VehicleModel::~VehicleModel()
{
    qDeleteAll(vehicles);
    vehicles.clear();
}

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
    return 11;
}

QVariant VehicleModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= vehicles.size())
        return QVariant();
    const Vehicle *vehicle = vehicles.at(index.row());
    switch (role) {
    case IdRole : return vehicle->getId();
    case TypeRole: return vehicle->getTypeString();
    case BrandRole: return vehicle->getBrand();
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

QVariant VehicleModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(orientation == Qt::Horizontal && role == Qt::DisplayRole) {
        switch(section) {
        case 0: return "Choice";
        case 1: return "ID";
            case 7: return "Type";
            case 2: return "Brand";
            case 3: return "Model";
            case 4: return "Year";
            case 5: return "Version";
            case 6: return "Engine";
            case 8: return "VIN";
            case 9: return "Registration";
            case 10: return "Action";
            default: return QVariant();
        }
    } return QVariant();
}

QHash<int, QByteArray> VehicleModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();

    roles[IdRole] = "id";
    roles[TypeRole] = "type";
    roles[BrandRole] = "brand";
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
    qDebug()<<"SetData activated";
    qDeleteAll(vehicles);
    vehicles.clear();

    for (Vehicle* vehicle : _vehicles) {
        vehicle->setParent(this);
        QQmlEngine::setObjectOwnership(vehicle, QQmlEngine::CppOwnership); // QML can not delete objects now
    }
    vehicles = _vehicles;
    selected.fill(false, vehicles.size());
        qDebug()<<"Till now works, vehicles size: "<<vehicles.size();
    endResetModel();
}

void VehicleModel::toggleSelection(int index) {
    if (index < 0 || index >= selected.size())
        return;

    selected[index] = !selected[index];
    qDebug()<<"Method working, selected: "<<selected;
    emit dataChanged(createIndex(index, 0), createIndex(index, columnCount() - 1), {SelectedRole});
}

QVector<Vehicle*> VehicleModel::getSelectedVehicles() const {
    QVector<Vehicle*> selectedVehicles;
    for (int i = 0; i < selected.size(); ++i) {
        if (selected[i]) {
            selectedVehicles.append(vehicles[i]);
        }
    }
    qDebug()<<"Size of selected vehicles vector: "<< selectedVehicles.size();
    return selectedVehicles;
}

QVector<int> VehicleModel::getVehiclesIds() const
{
    QVector<int> vehiclesIds;
    for (int i = 0; i < selected.size(); ++i) {
        if (selected[i]) {
            vehiclesIds.append(vehicles[i]->getId());
        }
    }
    qDebug()<<"Size of selected vehicles vector: "<< vehiclesIds.size();
    return vehiclesIds;
}

QVector<Vehicle *> VehicleModel::getVehicles() const
{
    return vehicles;
}

Vehicle *VehicleModel::getVehicleByRow(int row) const
{
    if(row >=0 && row < vehicles.size()) {
        return vehicles[row];
    } else return nullptr;
}

Vehicle *VehicleModel::getVehicleById(int id) const
{
    if(id>=0) {
       auto it = std::find_if(vehicles.begin(), vehicles.end(), [id]( Vehicle *vehicle){
            return vehicle->getId() == id;
});
if (it != vehicles.end()) {
           return *it;
        }
    }
    return nullptr;
}

int VehicleModel::getVehicleByRegistration(QString regNb)
{
    for(int row = 0; row<vehicles.size();row++) {
        if(vehicles[row]->getRegistrationNumber() == regNb.toUpper()) {
            return row;
        }
    } return -1;
}
