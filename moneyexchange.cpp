#include "moneyexchange.h"

using namespace std;

MoneyExchange::MoneyExchange() {}

MoneyExchange::MoneyExchange(QString cur, QString cou, QString sym, float ave)
    : currency(cur), country(cou), symbol(sym), averageExchange(ave){}

QDebug operator<<(QDebug out, const MoneyExchange &exchange)
{
    QDebugStateSaver stateSaver(out);
    out.space() << exchange.currency << exchange.country << exchange.symbol << exchange.averageExchange;
    return out;
}
