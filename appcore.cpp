#include "appcore.h"

#include <string>

#define REQUEST_TIME (15*60*1000)

size_t findAllQSubstring(QString qstr, QString find);

AppCore::AppCore(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager();
    connect(manager, &QNetworkAccessManager::finished, this, &AppCore::managerFinished);

    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &AppCore::onRequest);
    timer->start(REQUEST_TIME);

    onRequest();
}

void AppCore::managerFinished(QNetworkReply *reply)
{
    if(reply->error()) {
        qDebug() << reply->errorString();
        return;
    }

    QString answer = reply->readAll();

    size_t answerSize = findAllQSubstring(answer, "currency");
    exchange.resize(answerSize);

    QJsonDocument doc = QJsonDocument::fromJson(answer.toUtf8());

    if(doc.isArray())
    {
        for(size_t i = 0; i < exchange.size(); i++)
        {
            QString currency = doc[i].toObject().value("currency").toString();
            QString country = doc[i].toObject().value("country").toString();
            QString symbol = doc[i].toObject().value("symbol").toString();
            int temp = symbol.indexOf(' ');
            symbol.remove(0, temp+1);
            QString averageExchange = doc[i].toObject().value("averageExchange").toString();
            averageExchange.replace(',', '.');

            exchange[i] = MoneyExchange(currency, country, symbol, averageExchange.toFloat());

            //qDebug() << exchange[i];
        }
    }

    emit isDataChanged();
}

void AppCore::onRequest()
{
    qDebug() << "Recive";

    QString requeststring = "http://localhost:8080/currency/all";
    request.setUrl(QUrl(requeststring));
    manager->get(request);
}

QString AppCore::getDataExchangeCurrency(int index)
{
    return exchange[index].getCurrency();
}

QString AppCore::getDataExchangeSymbol(int index)
{
    return exchange[index].getSymbol();
}

float AppCore::getDataExchangeAverageExchange(int index)
{
    return exchange[index].getAverangeExchange();
}

size_t findAllQSubstring(QString qstr, QString find)
{
    size_t count = 0;
    int j = 0;
    while((j = qstr.indexOf(find, j+1)) != -1)
        count++;

    return count;
}
