#ifndef MONEYEXCHANGE_H
#define MONEYEXCHANGE_H

#include <QString>
#include <QDebug>

class MoneyExchange
{
    QString currency;
    QString country;
    QString symbol;
    float averageExchange;

public:
    MoneyExchange();
    MoneyExchange(QString cur, QString cou, QString sym, float ave);

    inline QString getCurrency() { return currency; }
    inline QString getCountry() { return country; }
    inline QString getSymbol() { return symbol; }
    inline float getAverangeExchange() { return averageExchange; }

    friend QDebug operator<<(QDebug out, const MoneyExchange &exchange);
};

#endif // MONEYEXCHANGE_H
