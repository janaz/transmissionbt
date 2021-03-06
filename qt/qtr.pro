TARGET = transmission-qt
NAME = "Transmission"
DESCRIPTION = "Transmission: a fast, easy, and free BitTorrent client"
VERSION = 2.81
LICENSE = "GPL"

target.path = /bin
INSTALLS += target

unix: INSTALLS += man
man.path = /share/man/man1/
man.files = transmission-qt.1

CONFIG += qt thread debug link_pkgconfig c++11 warn_on
QT += network dbus
PKGCONFIG = fontconfig libcurl openssl libevent

greaterThan(QT_MAJOR_VERSION, 4) {
    QT += widgets
}

DEFINES += QT_NO_CAST_FROM_ASCII
win32:DEFINES += QT_DBUS

TRANSMISSION_TOP = ..

include(config.pri)

INCLUDEPATH = $${EVENT_TOP}/include $${INCLUDEPATH}
INCLUDEPATH += $${TRANSMISSION_TOP}
LIBS += $${TRANSMISSION_TOP}/libtransmission/libtransmission.a
LIBS += $${LIBUTP_LIBS}
LIBS += $${DHT_LIBS}
LIBS += $${LIBB64_LIBS}
LIBS += $${LIBUPNP_LIBS}
LIBS += $${LIBNATPMP_LIBS}
unix: LIBS += -L$${EVENT_TOP}/lib -lz -lrt
win32:LIBS += -levent-2.0 -lws2_32 -lintl
win32:LIBS += -lidn -liconv -lwldap32 -liphlpapi

lessThan(QT_MAJOR_VERSION, 5):*-g++*:QMAKE_CXXFLAGS += -std=gnu++11

TRANSLATIONS += translations/transmission_en.ts \
                translations/transmission_es.ts \
                translations/transmission_eu.ts \
                translations/transmission_fr.ts \
                translations/transmission_hu.ts \
                translations/transmission_kk.ts \
                translations/transmission_lt.ts \
                translations/transmission_pt_BR.ts \
                translations/transmission_ru.ts \
                translations/transmission_uk.ts \
                translations/transmission_zh_CN.ts

FORMS += about.ui \
         details.ui \
         mainwin.ui \
         make-dialog.ui \
         make-progress-dialog.ui \
         options.ui \
         prefs-dialog.ui \
         relocate.ui \
         session-dialog.ui \
         stats-dialog.ui
RESOURCES += application.qrc
win32|macx:RESOURCES += icons/Faenza/Faenza.qrc
SOURCES += about.cc \
           add-data.cc \
           app.cc \
           column-resizer.cc \
           dbus-adaptor.cc \
           details.cc \
           favicon.cc \
           file-tree.cc \
           filterbar.cc \
           filters.cc \
           freespace-label.cc \
           formatter.cc \
           hig.cc \
           license.cc \
           mainwin.cc \
           make-dialog.cc \
           options.cc \
           path-button.cc \
           prefs.cc \
           prefs-dialog.cc \
           relocate.cc \
           rpc-client.cc \
           session.cc \
           session-dialog.cc \
           squeezelabel.cc \
           stats-dialog.cc \
           torrent.cc torrent-delegate.cc \
           torrent-delegate-min.cc \
           torrent-filter.cc \
           torrent-model.cc \
           tracker-delegate.cc \
           tracker-model.cc \
           tracker-model-filter.cc \
           tricontoolbutton.cc \
           utils.cc \
           watchdir.cc
HEADERS += $$replace(SOURCES, .cc, .h)
HEADERS += speed.h types.h

win32:RC_FILE = qtr.rc
