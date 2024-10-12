#ifndef SESSIONCONTROLLER_H
#define SESSIONCONTROLLER_H

#include <QObject>
#include "customer.h"

class SessionController : public QObject
{
    Q_OBJECT
public:
    explicit SessionController(QObject *parent = nullptr);

    std::shared_ptr<Customer> getCurrentCustomer() const;
    void setCurrentCustomer(const std::shared_ptr<Customer> &newCurrentCustomer);
    void printingPtr() const;

public slots:
    void successfullyLogged(std::shared_ptr<Customer> &customer);
private:
    std::shared_ptr<Customer> currentCustomer;
};

#endif // SESSIONCONTROLLER_H
