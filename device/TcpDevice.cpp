#include "TcpDevice.h"
#include <QDebug>

bool TcpDevice::open(const QString &addr)
{
    qInfo() << "[TcpDevice] open ->" << addr;
    m_open = true;
    emit sigStateChanged(true, QStringLiteral("已连接 %1").arg(addr));
    return true;
}

void TcpDevice::close()
{
    if (!m_open) return;
    m_open = false;
    emit sigStateChanged(false, QStringLiteral("已断开"));
}

QByteArray TcpDevice::query(const QString &cmd)
{
    qInfo() << "[TcpDevice] query ->" << cmd;
    return "BALUELEC,SA4200,SN001,V1.0\n";   // 先返回假数据，D16 换成真链路
}
