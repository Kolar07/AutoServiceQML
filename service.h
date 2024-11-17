#ifndef SERVICE_H
#define SERVICE_H

#include <QObject>
#include <QDate>

class Service : public QObject
{
    Q_OBJECT
public:
    explicit Service(QObject *parent = nullptr);
    Service(int _id, int _milleage, QString _type, QString date);
    Service(int _milleage, QString _type, QString date);

    virtual void print()=0;
    virtual int getInterval_time()const = 0;
    Q_INVOKABLE int getId() const;
    void setId(int newId);

    Q_INVOKABLE int getMileage() const;
    void setMilleage(int newMilleage);

    Q_INVOKABLE QString getType() const;
    void setType(const QString &newType);

    Q_INVOKABLE QDate getServiceDate() const;
    void setServiceDate(const QDate &newServiceDate);

private:
    int id;
    int mileage;
    QString type;
    QDate serviceDate;

signals:
};

#endif // SERVICE_H
