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
    case MileageRole: return service->getMileage();
    case TypeRole: return service->getType();
    case ServiceDateRole: return service->getServiceDate().toString("yyyy-MM-dd");
    case SelectedRole: return selectedServices.at(index.row());
    }

    if (auto repairService = dynamic_cast<RepairService*>(service.get())) {
        if (role == CustomPartsRole) return repairService->getCustomParts();
        if(role == IntervalKmRole) return repairService->getInterval_km();
        if(role == IntervalTimeRole) return repairService->getInterval_time();
        if(role == ServiceRole) return repairService->getService();
    }

    else if(auto oilService = dynamic_cast<ServiceOil*>(service.get())) {
        if(role == OilRole) return oilService->getOil();
        if(role == OilFilterRole) return oilService->getOilFilter();
        if(role == AirFilterRole) return oilService->getAirFilter();
        if(role == CabinFilterRole) return oilService->getCabinFilter();
        if(role == IntervalKmRole) return oilService->getInterval_km();
        if(role == IntervalTimeRole) return oilService->getInterval_time();
        if(role == ServiceRole) return oilService->getService();
    }

    else if(auto timingService = dynamic_cast<ServiceTiming*>(service.get())) {
        if(role == TimingRole) return timingService->getTiming();
        if(role == IntervalKmRole) return timingService->getInterval_km();
        if(role == IntervalTimeRole) return timingService->getInterval_time();
        if(role == ServiceRole) return timingService->getService();
    }

    else if(auto maintenanceService = dynamic_cast<MaintenanceService*>(service.get())) {
        if(role == IntervalKmRole) return maintenanceService->getInterval_km();
        if(role == IntervalTimeRole) return maintenanceService->getInterval_time();
        if(role == ServiceRole) return maintenanceService->getService();
    }

    return "-";

}

QVariant ServiceModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(orientation == Qt::Horizontal && role == Qt::DisplayRole) {
        switch(section) {
        case 0: return "Choice";
        case 1: return "ID";
        case 2: return "Type";
        case 3: return "Date";
        case 4: return "Interval";
        case 5: return "Next Service";
        case 6: return "Service";
        case 7: return "Mileage";
        case 8: return "Oil";
        case 9: return "Oil Filter";
        case 10: return "Air Filter";
        case 11: return "Cabin Filter";
        case 12: return "Timing";
        case 13: return "Custom Repair Parts";
        case 14: return "Action";
        default: return QVariant();
        }
    } return QVariant();
}

QHash<int, QByteArray> ServiceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
        roles[Qt::DisplayRole] = "display";
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
    roles[CustomPartsRole] = "customParts";
    roles[SelectedRole] = "selectedService";
    return roles;
}

void ServiceModel::setData(QVector<std::shared_ptr<Service>> &_services)
{

    qDebug() << "DEBUG - Entering setData.";
    qDebug() << "DEBUG - Services count:" << _services.size();

    beginResetModel();
    qDebug()<<"DEBUG - SETTING SERVICES RESETING MODEL";
    for (auto& service : _services) {
        service->setParent(this);
    }

    services = std::move(_services);
    selectedServices.resize(services.size(), false);
    qDebug() << "DEBUG - Services reset complete. Total services:" << services.size();
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
    QVector<std::shared_ptr<Service>> selected;
    for(int i = 0; i < selectedServices.size(); i++) {
        if(selectedServices[i]){
            selected.append(services[i]);
        }
    }
    return selected;
}

QVector<int> ServiceModel::getSelectedServicesIds() const
{
    QVector<int> servicesIds;
    for(int i = 0;i<selectedServices.size();i++) {
        if(selectedServices[i]){
            servicesIds.append(services[i]->getId());
        }
    }
    return servicesIds;
}

QVector<std::shared_ptr<Service> > ServiceModel::getServices() const
{
    return services;
}

std::shared_ptr<Service> ServiceModel::getServiceByRow(int row) const
{
    if(row >=0 && row < services.size()) {
        qDebug()<<"Service by row: "<<row<<" id:" <<services[row]->getId();
        return services[row];
    } else return nullptr;
}

std::shared_ptr<Service> ServiceModel::getServiceById(int id) const
{
    if(id>=0) {
        auto it = std::find_if(services.begin(), services.end(), [id]( std::shared_ptr<Service> service){
            return service->getId() == id;
        });
        if (it != services.end()) {
            return *it;
        }
    }
    return nullptr;
}

QObject* ServiceModel::getServiceByRowQML(int row) const
{
    if (row >= 0 && row < services.size()) {
        Service* service = services[row].get();

        if (!service->parent()) {
            service->setParent(const_cast<ServiceModel*>(this));
                    qDebug()<<"Now has a parent";
        }

        return service;
    } else {
        return nullptr;
    }
}


QObject* ServiceModel::getServiceByIdQML(int id) const
{
    if (id >= 0) {
        auto it = std::find_if(services.begin(), services.end(), [id](std::shared_ptr<Service> service) {
            return service->getId() == id;
        });

        if (it != services.end()) {
            Service* service = it->get();

            if (!service->parent()) {
                service->setParent(const_cast<ServiceModel*>(this));
                qDebug()<<"Now has a parent";
            }
            return service;
        }
    }
    return nullptr;
}
