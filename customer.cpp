#include "customer.h"

Customer::Customer(QObject *parent)
    : QObject{parent}
{}
QString Customer::getName() const
{
    return name;
}

void Customer::setName(const QString &newName)
{
    name = newName;
}

QString Customer::getSurname() const
{
    return surname;
}

void Customer::setSurname(const QString &newSurname)
{
    surname = newSurname;
}

QString Customer::getEmail() const
{
    return email;
}

void Customer::setEmail(const QString &newEmail)
{
    email = newEmail;
}

QString Customer::getPassword() const
{
    return password;
}

void Customer::setPassword(const QString &newPassword)
{
    password = newPassword;
}
