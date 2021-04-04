#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

#include <QtNetwork/QNetworkAccessManager>
#include<QtNetwork/QNetworkRequest>
#include<QtNetwork/QNetworkReply>
#include<QtNetwork/QHttpPart>

#include<QJsonObject>
#include<QJsonArray>
#include<QJsonParseError>

#include<QTimer>
#include<QtDebug>

#include <QQmlListProperty>

#include "moneyexchange.h"

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = nullptr);

private:
    void managerFinished(QNetworkReply*reply);

    QNetworkAccessManager *manager;
    QNetworkRequest request;

    std::vector<MoneyExchange> exchange;

public slots:
    void onRequest();
    inline int getSizeExchange() { return exchange.size(); }
    QString getDataExchangeCurrency(int index);
    QString getDataExchangeSymbol(int index);
    float getDataExchangeAverageExchange(int index);
signals:
    void isDataChanged();
};

#endif // APPCORE_H
