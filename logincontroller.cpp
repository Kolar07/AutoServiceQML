#include "logincontroller.h"

LoginController::LoginController(Customer *_customer,DatabaseController *_db,QObject *parent)
    : QObject{parent}, customer{_customer}, db{_db}
{}

std::shared_ptr<Customer> LoginController::login(QString &email, QString &password)
{
    if(email.isEmpty() || password.isEmpty()) {
        qDebug()<<"While logging in: email or password is empty";
        return nullptr;
    }

    QMap<QString, QVariant> customerFromDB = db->getCustomerByEmail(email);
    QStringList parts = customerFromDB.value("password").toString().split(":");
    if(parts.size()!=2){
        qDebug()<<"Wrong data format";
        return nullptr;
    }
    QByteArray storedSalt = QByteArray::fromBase64(parts[1].toUtf8());
    //QByteArray storedPassword = QByteArray::fromBase64(parts[0].toUtf8());

    RegisterController temp;
    if(temp.hashPassword(password,storedSalt) == customerFromDB.value("password").toString()) {
        customer->setId(customerFromDB.value("id").toInt());
        customer->setEmail(customerFromDB.value("email").toString());
        customer->setPassword(customerFromDB.value("password").toString());
        customer->setName(customerFromDB.value("name").toString());
        customer->setSurname(customerFromDB.value("surname").toString());
        qDebug()<<"CUSTOMER LOGGED IN!";
        //SET VEHICLE LIST TO CUSTOMER AFTER LOGIN
        return customer;
    } return nullptr;
}
