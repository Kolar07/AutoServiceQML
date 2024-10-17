#ifndef SERVICE_H
#define SERVICE_H

#include <QObject>

class Service : public QObject
{
    Q_OBJECT
public:
    explicit Service(QObject *parent = nullptr);
    Service(int _id, int _milleage, QString _type);

    virtual void print()=0;
private:
    int id;
    int milleage;
    QString type;

signals:
};

#endif // SERVICE_H
