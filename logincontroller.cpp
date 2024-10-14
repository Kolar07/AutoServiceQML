#include "logincontroller.h"

LoginController::LoginController(Customer *_customer,DatabaseController *_db,QObject *parent)
    : QObject{parent}, customer{_customer}, db{_db}
{}

bool LoginController::login(QString email, QString password)
{
    if(email.isEmpty() || password.isEmpty()) {
        qDebug()<<"While logging in: email or password is empty";
        emit failedLogin();
        return false;
    }

    QMap<QString, QVariant> customerFromDB = db->getCustomerByEmail(email);
    QStringList parts = customerFromDB.value("password").toString().split(":");
    if(parts.size()!=2){
        qDebug()<<"Wrong data format";
        emit failedLogin();
        return false;
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
        qDebug()<<"Login controller pointer: "<<customer.get();
        emit successfullyLogged(customer);
        return true;
    } else
    qDebug()<<"WRONG PASSWORD!";
    emit failedLogin();
    return false;
}

std::shared_ptr<Customer> LoginController::getCustomer() const
{
    return customer;
}

void LoginController::printingPtr() const
{
    qDebug()<<"LoginController pointer: "<<&customer;
    qDebug()<<"Number of uses: "<<customer.use_count();
}
