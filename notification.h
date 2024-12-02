#ifndef NOTIFICATION_H
#define NOTIFICATION_H

#include <QObject>
#include <QDate>
#include <QColor>

class Notification : public QObject
{
    Q_OBJECT
public:
    explicit Notification(QObject *parent = nullptr);
    Notification(QDate _serviceDate,int _mileage, int _intervalMonths,int _intervalKm, QString _service,QString _serviceType, QString _vehicleRegistration);
    Notification(int _id,QDate _serviceDate,QDate _nextServiceDate, int _nextServiceKm, QString _service,QString _serviceType, QString _vehicleRegistration);

    int getId() const;
    void setId(int newId);

    QDate getServiceDate() const;
    void setServiceDate(const QDate &newServiceDate);

    QString getServiceDateString() const;

    QString getService() const;
    void setService(const QString &newService);

    QString getServiceType() const;
    void setServiceType(const QString &newServiceType);

    QString getVehicleRegistration() const;
    void setVehicleRegistration(const QString &newVehicleRegistration);

    QString getDaysLeft() const;

    QString getColor() const;

    QDate getNextServiceDate() const;
    void setNextServiceDate(const QDate &newNextServiceDate);

    QString getNextServiceDateString() const;

    int getNextServiceKm() const;
    void setNextServiceKm(int newNextServiceKm);

private:
    int id;
    QDate serviceDate;
    QDate nextServiceDate;
    int nextServiceKm;
    QString service;
    QString serviceType;
    QString vehicleRegistration;
signals:
};

#endif // NOTIFICATION_H
