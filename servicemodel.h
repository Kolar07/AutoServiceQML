#ifndef SERVICEMODEL_H
#define SERVICEMODEL_H

#include <QObject>
#include <QAbstractTableModel>
#include "service.h"
#include "serviceoil.h"
#include "servicetiming.h"
#include "repairservice.h"
#include "maintenanceservice.h"
#include <QQmlEngine>

class ServiceModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit ServiceModel(QObject *parent = nullptr);

    ServiceModel(ServiceModel &&other) noexcept;
    ServiceModel &operator=(ServiceModel &&other) noexcept;
    enum ServiceRoles {
        IdRole = Qt::UserRole + 1,
        MileageRole,
        TypeRole,
        ServiceDateRole,
        IntervalKmRole,
        IntervalTimeRole,
        ServiceRole,
        OilRole,
        OilFilterRole,
        AirFilterRole,
        CabinFilterRole,
        TimingRole,
        CustomPartsRole,
        SelectedRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

    void setData(QVector<std::shared_ptr<Service>> &_services);
    Q_INVOKABLE void toggleSelection(int index);
    Q_INVOKABLE QVector<std::shared_ptr<Service>> getSelectedServices() const;
    Q_INVOKABLE QVector<int> getSelectedServicesIds() const;


    Q_INVOKABLE QVector<std::shared_ptr<Service> > getServices() const;
    Q_INVOKABLE std::shared_ptr<Service> getServiceByRow(int row) const;
    Q_INVOKABLE std::shared_ptr<Service> getServiceById(int id) const;
    Q_INVOKABLE QObject* getServiceByRowQML(int row) const;
    //Q_INVOKABLE QPointer<Service> getServiceByRowQML(int row) const;
    Q_INVOKABLE QObject* getServiceByIdQML(int id) const;

private:
    QVector<std::shared_ptr<Service>> services;
    QVector<bool> selectedServices;

signals:
};

#endif // SERVICEMODEL_H
