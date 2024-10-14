#ifndef REGISTERCONTROLLER_H
#define REGISTERCONTROLLER_H

#include <QObject>
#include "customer.h"
#include <QCryptographicHash>
#include <QRandomGenerator>
#include <QDebug>
#include <QRegularExpression>

class RegisterController : public QObject
{
    Q_OBJECT
public:
    explicit RegisterController(Customer *_customer, QObject *parent = nullptr);
    RegisterController();

    Q_INVOKABLE void registerCustomer(QString name, QString surname, QString email, QString password, QString repeatPassword);
    QByteArray generateSalt();
    QString hashPassword(QString &password, QByteArray &salt, int iterations = 10000);

signals:
    void registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password);
    void registrationFailed(const QString &errorMessage);
    void registrationFailedPassword();
    void registrationFailedName();
    void registrationFailedSurname();
    void registrationFailedRepeatPassword();
    void registrationFailedEmail();

private:
    Customer *customer;

signals:
};

#endif // REGISTERCONTROLLER_H
