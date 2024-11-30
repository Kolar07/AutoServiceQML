#ifndef NOTIFICATIONTEMPLATE_H
#define NOTIFICATIONTEMPLATE_H

#include <QObject>
#include <QMap>

class NotificationTemplate : public QObject
{
    Q_OBJECT
public:
    explicit NotificationTemplate(QObject *parent = nullptr);
    NotificationTemplate(const QString &title, const QString &message);

    QString getTitle() const;
    void setTitle(const QString &newTitle);

    QString getMessage() const;
    void setMessage(const QString &newMessage);

    QString generateNotificationMessaage(const QMap<QString, QString>&variables)const;

private:
    QString title;
    QString message;

signals:
};

#endif // NOTIFICATIONTEMPLATE_H
