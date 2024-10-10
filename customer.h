#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QObject>
#include "vehicle.h"

class Customer : public QObject
{
    Q_OBJECT
public:
    explicit Customer(QObject *parent = nullptr);

    QString getName() const;
    void setName(const QString &newName);

    QString getSurname() const;
    void setSurname(const QString &newSurname);

    QString getEmail() const;
    void setEmail(const QString &newEmail);

    QString getPassword() const;
    void setPassword(const QString &newPassword);

private:
    QString name;
    QString surname;
    QString email;
    QString password;
    QList<Vehicle> vehicles;
};

#endif // CUSTOMER_H
