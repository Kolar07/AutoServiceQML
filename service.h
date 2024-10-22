#ifndef SERVICE_H
#define SERVICE_H

#include <QObject>

class Service : public QObject
{
    Q_OBJECT
public:
    explicit Service(QObject *parent = nullptr);
    Service(int _id, int _milleage, QString _type);
    Service(int _milleage, QString _type);

    virtual void print()=0;
    int getId() const;
    void setId(int newId);

    int getMilleage() const;
    void setMilleage(int newMilleage);

    QString getType() const;
    void setType(const QString &newType);

private:
    int id;
    int mileage;
    QString type;

signals:
};

#endif // SERVICE_H
