#include "notificationtemplate.h"

NotificationTemplate::NotificationTemplate(QObject *parent)
    : QObject{parent}
{}

NotificationTemplate::NotificationTemplate(const QString &_title, const QString &_message):title(_title), message(_message)
{

}

QString NotificationTemplate::getTitle() const
{
    return title;
}

void NotificationTemplate::setTitle(const QString &newTitle)
{
    title = newTitle;
}

QString NotificationTemplate::getMessage() const
{
    return message;
}

void NotificationTemplate::setMessage(const QString &newMessage)
{
    message = newMessage;
}

QString NotificationTemplate::generateNotificationMessaage(const QMap<QString, QString> &variables) const
{
    QString filledMessage = message;
    for(auto it = variables.begin(); it!=variables.end();it++) {
        QString placeholder = "{{" + it.key() + "}}";
        filledMessage.replace(placeholder,it.value());
    }
    return filledMessage;
}
