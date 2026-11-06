#pragma once
#include "Device.h"

class TcpDevice : public Device
{
    Q_OBJECT
public:
    explicit TcpDevice(QObject *parent = nullptr) : Device(parent) {}
    ~TcpDevice() override { close(); }        // override 让编译器帮你查签名

    bool open(const QString &addr) override;  // D15 再填真正的 QTcpSocket 代码
    void close() override;
    QByteArray query(const QString &cmd) override;
    bool isOpen() const override { return m_open; }

private:
    bool m_open = false;
};
