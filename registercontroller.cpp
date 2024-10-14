#include "registercontroller.h"

RegisterController::RegisterController(Customer *_customer,QObject *parent)
    : QObject{parent}, customer{_customer}
{}

RegisterController::RegisterController()
{}

void RegisterController::registerCustomer(QString name, QString surname, QString email, QString password, QString repeatPassword)
{

    static QRegularExpression nameRegex("^[A-Za-z]+$");
    static QRegularExpression emailRegex("^[\\w\\.-]+@[\\w\\.-]+\\.[A-Za-z]{2,}$");

    if (name.isEmpty() || !nameRegex.match(name).hasMatch()) {
        emit registrationFailedName();
        return;
    }

    if (surname.isEmpty() || !nameRegex.match(surname).hasMatch()) {
        emit registrationFailedSurname();
        return;
    }

    if (email.isEmpty() || !emailRegex.match(email).hasMatch()) {
        emit registrationFailedEmail();
        return;
    }

    if(password.length()<8) {
        emit registrationFailedPassword();
        return;
    }

    if(password != repeatPassword) {
        emit registrationFailedRepeatPassword();
        return;
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


