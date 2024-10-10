#ifndef LOGINCONTROLLER_H
#define LOGINCONTROLLER_H

#include <QObject>
#include "customer.h"
#include "databasecontroller.h"
#include "registercontroller.h"

class LoginController : public QObject
{
    Q_OBJECT
public:
    explicit LoginController(Customer *_customer, DatabaseController *_db,  QObject *parent = nullptr);
    std::shared_ptr<Customer> login(QString &email, QString &password);

signals:

private:
    std::shared_ptr<Customer> customer;
    std::unique_ptr<DatabaseController> db;

};

#endif // LOGINCONTROLLER_H
