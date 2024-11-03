#ifndef VEHICLETYPECONTAINER_H
#define VEHICLETYPECONTAINER_H

#include<QAbstractTableModel>

class VehicleTypeContainer : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit VehicleTypeContainer(QObject *parent = nullptr);

    enum VehicleTypeRoles{
        IdRole = Qt::UserRole+1,
        TypeNameRole
    };

    void setVehicleTypes(const QVector<QPair<int,QString>> &vehicleTypes);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE bool findType(QString type) const;
    Q_INVOKABLE int findIndex(int id) const;

    QHash<int, QByteArray> roleNames() const override;


public slots:
    void onVehicleTypesFetched(QVector<QPair<int,QString>> vehicleTypes);

private:
    QVector<QPair<int,QString>> types;

};

#endif // VEHICLETYPECONTAINER_H
