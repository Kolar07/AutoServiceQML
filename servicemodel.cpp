#include "servicemodel.h"

ServiceModel::ServiceModel(QObject *parent)
    : QAbstractTableModel{parent}
{}

ServiceModel::ServiceModel(ServiceModel &&other) noexcept
    :QAbstractTableModel(other.parent()),
    services(std::move(other.services)),
    selected(std::move(other.selected)) {}



ServiceModel &ServiceModel::operator=(ServiceModel &&other) noexcept
{
    if (this == &other)
        return *this;
    services = std::move(other.services);
    selected = std::move(other.selected);
    return *this;
}

int ServiceModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return services.size();
}

int ServiceModel::columnCount(const QModelIndex &parent) const
{
    return 15;
}

QVariant ServiceModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= services.size())
        return QVariant();

    const auto &service = services.at(index.row());

    switch(role) {
    case IdRole: return service->getId();
    case MileageRole: return service->getMilleage();
    case TypeRole: return service->getType();
    case ServiceDateRole: return service->getServiceDate().toString("yyyy-MM-dd");
    }

    if(auto maintenanceService = dynamic_cast<MaintenanceService*>(service.get())) {
        if(role == IntervalKmRole) return maintenanceService->getInterval_km();
        if(role == IntervalTimeRole) return maintenanceService->getInterval_time().toString("yyyy-MM-dd");
        if(role == ServiceRole) return maintenanceService->getService();
    } else {
    if(role == IntervalKmRole) return "-";
    if(role == IntervalTimeRole) return "-";
    if(role == ServiceRole) return "-";
    }

    if(auto oilService = dynamic_cast<ServiceOil*>(service.get())) {
        if(role == OilRole) return oilService->getOil();
        if(role == OilFilterRole) return oilService->getOilFilter();
        if(role == AirFilterRole) return oilService->getAirFilter();
        if(role == CabinFilterRole) return oilService->getCabinFilter();
    } else {
        if(role == OilRole) return "-";
        if(role == OilFilterRole) return "-";
        if(role == AirFilterRole) return "-";
        if(role == CabinFilterRole) return "-";
    }

    if(auto timingService = dynamic_cast<ServiceTiming*>(service.get())) {
        if(role == TimingRole) return timingService->getTiming();
    } else if(role == TimingRole) return "-";

    if (auto repairService = dynamic_cast<RepairService*>(service.get())) {
        if (role == CustomPartsRole) return repairService->getCustomParts();
    } else if (role == CustomPartsRole) return "-";

    return QVariant();

}

QHash<int, QByteArray> ServiceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[MileageRole] = "mileage";
    roles[TypeRole] = "type";
    roles[ServiceDateRole] = "serviceDate";
    roles[IntervalKmRole] = "intervalKm";
    roles[IntervalTimeRole] = "intervalTime";
    roles[ServiceRole] = "service";
    roles[OilRole] = "oil";
    roles[OilFilterRole] = "oilFilter";
    roles[AirFilterRole] = "airFilter";
    roles[CabinFilterRole] = "cabinFilter";
    roles[TimingRole] = "timing";
    roles[CustomPartsRole] = "parts";
    roles[SelectedRole] = "selected";
    return roles;
}

void ServiceModel::toggleSelection(int index)
{
    if(index <0 || index >= selected.size()) {
        return;
    }
    selected[index] = !selected[index];
    emit dataChanged(createIndex(index, 0), createIndex(index,0), {SelectedRole});
}

QVector<std::shared_ptr<Service> > ServiceModel::getSelectedServices() const
{
    QVector<std::shared_ptr<Service>> selectedServices;
    for(int i = 0; i < selected.size(); i++) {
        if(selected[i]){
            selectedServices.append(services[i]);
        }
    }
    return selectedServices;
}
