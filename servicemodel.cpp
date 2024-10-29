#include "servicemodel.h"

ServiceModel::ServiceModel(QObject *parent)
    : QAbstractTableModel{parent}
{}

ServiceModel::ServiceModel(ServiceModel &&other) noexcept
    :QAbstractTableModel(other.parent()),
    services(std::move(other.services)),
    selectedServices(std::move(other.selectedServices)) {}



ServiceModel &ServiceModel::operator=(ServiceModel &&other) noexcept
{
    if (this == &other)
        return *this;
    services = std::move(other.services);
    selectedServices = std::move(other.selectedServices);
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
    case SelectedRole: return selectedServices.at(index.row());
    }

    if(auto maintenanceService = dynamic_cast<MaintenanceService*>(service.get())) {
        if(role == IntervalKmRole) return maintenanceService->getInterval_km();
        if(role == IntervalTimeRole) return maintenanceService->getInterval_time().toString("yyyy-MM-dd");
        if(role == ServiceRole) return maintenanceService->getService();
    }
    else if(auto oilService = dynamic_cast<ServiceOil*>(service.get())) {
        if(role == OilRole) return oilService->getOil();
        if(role == OilFilterRole) return oilService->getOilFilter();
        if(role == AirFilterRole) return oilService->getAirFilter();
        if(role == CabinFilterRole) return oilService->getCabinFilter();
    }
    else if(auto timingService = dynamic_cast<ServiceTiming*>(service.get())) {
        if(role == TimingRole) return timingService->getTiming();
    }
    else if (auto repairService = dynamic_cast<RepairService*>(service.get())) {
        if (role == CustomPartsRole) return repairService->getCustomParts();
    }

    return "-";

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
    roles[SelectedRole] = "selectedService";
    return roles;
}

void ServiceModel::setData(QVector<std::shared_ptr<Service> > &_services)
{
    beginResetModel();
    services = _services;
    selectedServices.resize(services.size(), false);
    endResetModel();
}

void ServiceModel::toggleSelection(int index)
{
    if(index <0 || index >= selectedServices.size()) {
        return;
    }
    selectedServices[index] = !selectedServices[index];
    qDebug()<<"Method working, selected: "<<selectedServices;
    emit dataChanged(createIndex(index, 0), createIndex(index,0), {SelectedRole});
}

QVector<std::shared_ptr<Service> > ServiceModel::getSelectedServices() const
{
    QVector<std::shared_ptr<Service>> selectedServices;
    for(int i = 0; i < selectedServices.size(); i++) {
        if(selectedServices[i]){
            selectedServices.append(services[i]);
        }
    }
    return selectedServices;
}
