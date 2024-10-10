#include "databasecontroller.h"

DatabaseController::DatabaseController(const QString &hostname, const QString &username, const QString &password, const QString &dbName)
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setDatabaseName(dbName);
    db.setHostName(hostname);
    db.setUserName(username);
    db.setPassword(password);
}

DatabaseController::~DatabaseController()
{
    close();
}

bool DatabaseController::open() {
    if(!db.open()){
        qDebug()<<"Database error: "<< db.lastError().text();
        return false;
    }
    qDebug()<<"Works fine brutha";
    return true;
}

void DatabaseController::close()
{
    if(db.isOpen()){
        db.close();
    }
}

bool DatabaseController::addCustomer(QString name, QString surname, QString email, QString password)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return false;
    }
    qDebug()<<"Adding to database";
    QSqlQuery query;
    query.prepare("INSERT INTO customers (name, surname, email, password) VALUES (?,?,?,?)");
    query.addBindValue(name);
    query.addBindValue(surname);
    query.addBindValue(email);
    query.addBindValue(password);

    if(!query.exec()) {
        qDebug()<<"Failed to add new customer to database.";
        return false;
    }
    return true;

}

bool DatabaseController::changeCustomerPassword(int &customerId, QString &newPassword)
{
    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return false;
    }
    QSqlQuery query;
    query.prepare("UPDATE customers SET password = :password WHERE id = :id");
    query.bindValue(":password", newPassword);
    query.bindValue(":id", customerId);

    if(!query.exec()) {
        qDebug()<<"Failed to add new customer to database.";
        return false;
    }
    return true;
}

QMap<QString, QVariant> DatabaseController::getCustomerByEmail(QString &email)
{
    QMap<QString, QVariant> customerData;

    if(!db.open()) {
        qDebug()<<"Database is not open!";
        return customerData;
    }

    QSqlQuery query;
    query.prepare("SELECT * from customers WHERE email = :email");
    query.bindValue(":email", email);
    if(!query.exec()) {
        qDebug()<<"Failed to execute query.";
        return customerData;
    }

    if(query.next()) {
        QSqlRecord record = query.record();
        for(int i=0; i<record.count(); i++) {
            customerData.insert(record.fieldName(i), record.value(i));
        }
        qDebug() << "Got customer data from database for email:" << email;
    } else {
        qDebug() << "No customer found with that email:" << email;
    }
    return customerData;
}

void DatabaseController::registrationSuccess(const QString &name, const QString &surname, const QString &email, const QString &password)
{
    qDebug()<<"Performing signal answer";
    if(!addCustomer(name,surname,email,password)){
        qDebug()<<"DATABASE SLOT : CUSTOMER NOT ADDED";
    } else {
        qDebug()<<"DATABASE SLOT: CUSTOMER ADDED";
    }
}
