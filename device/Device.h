#pragma once
#include <QObject>
#include <QString>
#include <QByteArray>

// 抽象设备接口：UI / 业务层只依赖这个接口，不认识 TCP 还是串口
class Device : public QObject
{
    Q_OBJECT
public:
    explicit Device(QObject *parent = nullptr) : QObject(parent) {}
    virtual ~Device() = default;              // 必须 virtual，否则派生类资源泄漏

    virtual bool open(const QString &addr) = 0;
    virtual void close() = 0;
    virtual QByteArray query(const QString &cmd) = 0;
    virtual bool isOpen() const = 0;

signals:
    void sigStateChanged(bool online, const QString &msg);
    void sigError(const QString &what);
};
