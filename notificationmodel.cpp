#include "notificationmodel.h"

NotificationModel::NotificationModel(QObject *parent)
    : QAbstractListModel(parent)
{}

int NotificationModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return notifications.size();
}

QVariant NotificationModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= notifications.size())
        return QVariant();

    const Notification *notification = notifications.at(index.row());

    switch(role) {
    case IdRole: return notification->getId();
    case serviceTypeRole: return notification->getServiceType();
    case serviceRole: return notification->getService();
    case serviceDateRole: return notification->getServiceDateString();
    case nextServiceDateRole: return notification->getNextServiceDateString();
    case nextServiceKmRole: return notification->getNextServiceKm();
    case daysLeftRole: return notification->getDaysLeft();
    case vehicleRegistrationRole: return notification->getVehicleRegistration();
    case colorRole: return notification->getColor();
    default: return QVariant();
    }
}

QHash<int, QByteArray> NotificationModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "display";
    roles[IdRole] = "id";
    roles[serviceTypeRole] = "serviceType";
    roles[serviceRole] = "service";
    roles[serviceDateRole] = "serviceDate";
    roles[nextServiceDateRole] = "nextServiceDate";
    roles[nextServiceKmRole] = "nextServiceKm";
    roles[daysLeftRole] = "daysLeft";
    roles[vehicleRegistrationRole] = "vehicleRegistration";
    roles[colorRole] = "backgroundColor";
    return roles;
}

void NotificationModel::setData(QVector<Notification *> &_notifications)
{
    beginResetModel();
    qDeleteAll(notifications);
    notifications.clear();

    for (Notification* notification: _notifications) {
        notification->setParent(this);
        QQmlEngine::setObjectOwnership(notification, QQmlEngine::CppOwnership);
    }

    notifications = _notifications;
    endResetModel();
}
