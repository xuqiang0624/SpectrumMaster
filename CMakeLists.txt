cmake_minimum_required(VERSION 3.22)          # Qt6 要求 >= 3.22
project(SpectrumMaster LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)                         # Q_OBJECT / 信号槽必须
set(CMAKE_AUTOUIC ON)                         # .ui -> ui_xxx.h
set(CMAKE_AUTORCC ON)                         # .qrc -> 资源数组

# D1 先验证五个模块都能 find_package 到（本机实测全部已安装）
find_package(Qt6 REQUIRED COMPONENTS Widgets Network SerialPort Charts PrintSupport)

add_executable(${PROJECT_NAME}
    app/main.cpp
    device/Device.h
    device/TcpDevice.h
    device/TcpDevice.cpp
)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/app
    ${CMAKE_CURRENT_SOURCE_DIR}/device)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Widgets
    Qt6::Network
    Qt6::SerialPort
    Qt6::Charts
    Qt6::PrintSupport)

# add_subdirectory(widgets)                  # D10 建好 widgets/ 后再取消注释
# target_link_libraries(${PROJECT_NAME} PRIVATE widgets)

if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /utf-8)
endif()
