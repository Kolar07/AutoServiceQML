#ifndef VEHICLEMODEL_H
#define VEHICLEMODEL_H

#include <QAbstractTableModel>
#include <vehicle.h>


class VehicleModel : public QAbstractTableModel
{
    Q_OBJECT
public:

    enum VehicleRoles {
        IdRole = Qt::UserRole +1,
        TypeRole,
        MarkRole,
        ModelRole,
        YearRole,
        VersionRole,
        EngineRole,
        VinRole,
        RegNumberRole,
        SelectedRole,
    };

    VehicleModel(QObject *parent = nullptr);
    VehicleModel(VehicleModel &&other) noexcept;
    VehicleModel &operator=(VehicleModel &&other) noexcept;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;

    QHash<int, QByteArray> roleNames() const override;

    void setData(QVector<Vehicle*> &_vehicles);
    Q_INVOKABLE void toggleSelection(int index);
    Q_INVOKABLE QVector<Vehicle*> getSelectedVehicles() const;



    QVector<Vehicle *> getVehicles() const;

private:
    QVector<Vehicle*> vehicles;
    QVector<bool> selected;
};

#endif // VEHICLEMODEL_H
