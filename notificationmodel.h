#ifndef NOTIFICATIONMODEL_H
#define NOTIFICATIONMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QQmlEngine>
#include "notification.h"

class NotificationModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit NotificationModel(QObject *parent = nullptr);


    enum notificationRoles {
        IdRole = Qt::UserRole + 1,
        serviceTypeRole,
        serviceRole,
        serviceDateRole,
        nextServiceDateRole,
        nextServiceKmRole,
        daysLeftRole,
        vehicleRegistrationRole,
        colorRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray>roleNames() const override;
    void setData(QVector<Notification*> &_notifications);

private:
    QVector<Notification*> notifications;

signals:
};

#endif // NOTIFICATIONMODEL_H
