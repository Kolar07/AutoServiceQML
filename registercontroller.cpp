#include "registercontroller.h"

RegisterController::RegisterController(QObject *parent)
    : QObject{parent}
{}

void RegisterController::registerCustomer(QString &name, QString &surname, QString &email, QString &password)
{
    if(name.isEmpty() || surname.isEmpty() || email.isEmpty()){
        emit registrationFailed("Name, surname and email can not be empty!");
    }

    if(password.length()<8) {
        emit registrationFailed("Password must be over 8 characters long!");
    }

    QByteArray salt = generateSalt();
    QString hashed = hashPassword(password, salt);
    qDebug()<<"Emitting signal with name: "<<name;
    emit registrationSuccess(name, surname, email, hashed);
    //FETCH FROM DATABASE TO SET CUSTOMER ATTRIBUTES
}

QByteArray RegisterController::generateSalt()
{
    int length = 16;
    QByteArray salt;
    for(int i=0; i<length; i++) {
        salt.append(QRandomGenerator::global()->bounded(256));
    }
    return salt;
}

QString RegisterController::hashPassword(QString &password, QByteArray &salt, int iterations)
{
    QByteArray hash = salt + password.toUtf8();
    for(int i = 0; i<iterations; i++){
        hash = QCryptographicHash::hash(hash, QCryptographicHash::Sha3_256);
    }
    QString finalHashAndSalt = hash.toBase64() + ":" + salt.toBase64();
    return finalHashAndSalt;
}


