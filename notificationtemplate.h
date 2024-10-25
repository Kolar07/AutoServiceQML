#ifndef NOTIFICATIONTEMPLATE_H
#define NOTIFICATIONTEMPLATE_H

#include <QObject>

class NotificationTemplate : public QObject
{
    Q_OBJECT
public:
    explicit NotificationTemplate(QObject *parent = nullptr);

private:
    QString title;
    QString message; //type of service, next service date and days to the next service;

signals:
};

#endif // NOTIFICATIONTEMPLATE_H
