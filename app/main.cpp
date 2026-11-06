// D1 骨架：验证 Kit / moc / 五个 Qt 模块 / C++ 面向对象
#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QTimer>
#include <QDebug>
#include <QtGlobal>
#include "TcpDevice.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);          // 有窗口的 Qt 程序必须用 QApplication
    app.setApplicationName("SpectrumMaster");
    app.setOrganizationName("Qt28");

    qInfo() << "=== D1 environment check ===";
    qInfo() << "Qt runtime :" << qVersion();          // 应为 6.11.2
    qInfo() << "C++ standard:" << __cplusplus;        // 201703 = C++17

    // D1 的第二个练习：抽象接口 + 多态 + 虚析构
    Device *p = new TcpDevice;                // 基类指针指向派生对象
    p->open("127.0.0.1:5025");
    qInfo() << "query *IDN?:" << p->query("*IDN?");
    delete p;                                 // 虚析构 -> 派生类资源正常释放

    // 最小窗口：D5 会在这里接信号槽，D6 换成参数面板，D9 换成频谱控件
    QWidget w;
    w.setWindowTitle(QStringLiteral("SpectrumMaster · D1 骨架"));
    auto *v = new QVBoxLayout(&w);
    auto *title = new QLabel(QStringLiteral("频谱仪上位机 · 环境已就绪"), &w);
    auto *btn = new QPushButton(QStringLiteral("连接仪器（D5 接信号槽）"), &w);
    v->addWidget(title);
    v->addWidget(btn);
    v->addStretch(1);
    w.resize(520, 220);
    w.show();

    // 自检模式：设了环境变量就立刻退出，方便命令行验证；双击运行不受影响
    if (!qgetenv("QT28_SELFTEST").isEmpty())
        QTimer::singleShot(0, &app, &QCoreApplication::quit);

    return app.exec();                        // 进入事件循环
}
