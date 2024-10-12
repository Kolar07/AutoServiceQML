#ifndef LOGINCONTROLLER_H
#define LOGINCONTROLLER_H

#include <QObject>
#include "customer.h"
#include "databasecontroller.h"
#include "registercontroller.h"
#include <QDebug>

class LoginController : public QObject
{
    Q_OBJECT
public:
    explicit LoginController(Customer *_customer, DatabaseController *_db,  QObject *parent = nullptr);
    Q_INVOKABLE bool login(QString email, QString password);

    std::shared_ptr<Customer> getCustomer() const;

    void printingPtr() const;

signals:
    void successfullyLogged(std::shared_ptr<Customer> &customer);
    void failedLogin();

private:
    std::shared_ptr<Customer> customer;
    std::unique_ptr<DatabaseController> db;

};

#endif // LOGINCONTROLLER_H
