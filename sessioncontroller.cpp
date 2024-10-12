#include "sessioncontroller.h"

SessionController::SessionController(QObject *parent)
    : QObject{parent}
{}

void SessionController::successfullyLogged(std::shared_ptr<Customer> &customer)
{
    setCurrentCustomer(customer);
    qDebug()<<"Session controller pointer: "<<currentCustomer.get();
}

std::shared_ptr<Customer> SessionController::getCurrentCustomer() const
{
    return currentCustomer;
}

void SessionController::setCurrentCustomer(const std::shared_ptr<Customer> &newCurrentCustomer)
{
    currentCustomer = newCurrentCustomer;
}

void SessionController::printingPtr() const
{
    qDebug()<<"SessionController pointer: "<<&currentCustomer;
}
