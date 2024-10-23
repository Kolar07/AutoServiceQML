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
    virtual QDate getInterval_time()const = 0;
    int getId() const;
    void setId(int newId);

    int getMilleage() const;
    void setMilleage(int newMilleage);

    QString getType() const;
    void setType(const QString &newType);

    QDate getServiceDate() const;
    void setServiceDate(const QDate &newServiceDate);

private:
    int id;
    int mileage;
    QString type;
    QDate serviceDate;

signals:
};

#endif // SERVICE_H
