#include "slidemanager.h"
#include <QModelIndex>


SlideManager::SlideManager(QObject *parent)
    : QObject(parent)
{
    m_model.addSlide({ "Work",       "", "", "work" });
    m_model.addSlide({ "Ressources", "", "", "resources" });
    m_model.addSlide({ "Time",       "", "", "time" });

    //examplary fillings
    m_workItems.setStringList({"task a", "task b", "task c"});
    m_resourceItems.setStringList({"operator 1", "operator 2", "operator 3"});
    m_timeItems.setStringList({});

}

//accesibility functions can be filtered and reduced
int SlideManager::count() const{
    return m_model.rowCount();
}

QString SlideManager::titleAt(int idx) const {
    if(idx<0||idx>=m_model.rowCount()) return QString();
    QModelIndex mi = m_model.index(idx,0);
    return m_model.data(mi, SlideModel::TitleRole).toString();
}

QString SlideManager::notesAt(int idx) const {
    if(idx<0||idx>=m_model.rowCount()) return QString();
    QModelIndex mi = m_model.index(idx,0);
    return m_model.data(mi, SlideModel::NotesRole).toString();
}

QString SlideManager::dueDateAt(int idx) const {
    if(idx<0||idx>=m_model.rowCount()) return QString();
    QModelIndex mi = m_model.index(idx,0);
    return m_model.data(mi, SlideModel::DueDateRole).toString();
}

QString SlideManager::componentRoleAt(int idx) const {
    if(idx<0||idx>=m_model.rowCount()) return QString();
    QModelIndex mi = m_model.index(idx,0);
    return m_model.data(mi, SlideModel::ComponentRole).toString();
}

void SlideManager::setNotes(int idx, const QString &n) {
    m_model.setData(m_model.index(idx,0), n, SlideModel::NotesRole);
}

void SlideManager::setDueDate(int idx, const QString &d) {
    m_model.setData(m_model.index(idx,0), d, SlideModel::DueDateRole);
}
//arrow head functions

void SlideManager::next() {
    m_currentIndex = (m_currentIndex + 1) % m_model.rowCount();
    emit currentIndexChanged();
}

void SlideManager::previous() {
    m_currentIndex = (m_currentIndex-1 + m_model.rowCount()) % m_model.rowCount();
    emit currentIndexChanged();
}

//drag and drop handlers for each option

//void SlideManager::moveWorkToTime(int idx) {
//        if (idx<0||idx>=m_workItems.rowCount()) return;
//        auto mi = m_workItems.index(idx,0);
//        QString v = m_workItems.data(mi, Qt::DisplayRole).toString();
//        m_workItems.removeRows(idx,1);
//        int nr = m_timeItems.rowCount();
//        m_timeItems.insertRow(nr);
//        m_timeItems.setData(m_timeItems.index(nr,0), v, Qt::DisplayRole);
//    }
//
//void SlideManager::moveWorkToResource(int idx) {
//        if (idx<0||idx>=m_workItems.rowCount()) return;
//        auto mi = m_workItems.index(idx,0);
//        QString v = m_workItems.data(mi, Qt::DisplayRole).toString();
//        m_workItems.removeRows(idx,1);
//        int nr = m_resourceItems.rowCount();
//        m_resourceItems.insertRow(nr);
//        m_resourceItems.setData(m_resourceItems.index(nr,0), v, Qt::DisplayRole);
//    }
//
//void SlideManager::moveResourceToTime(int idx) {
//        if (idx<0||idx>=m_resourceItems.rowCount()) return;
//        auto mi = m_resourceItems.index(idx,0);
//        QString v = m_resourceItems.data(mi, Qt::DisplayRole).toString();
//        m_resourceItems.removeRows(idx,1);
//        int nr = m_timeItems.rowCount();
//        m_timeItems.insertRow(nr);
//        m_timeItems.setData(m_timeItems.index(nr,0), v, Qt::DisplayRole);
//    }
void SlideManager::moveWorkToTimeAt(int src, int dst) {
        if (src < 0 || src >= m_workItems.rowCount()) return;
        QString v = m_workItems.data(m_workItems.index(src,0), Qt::DisplayRole).toString();
        m_workItems.removeRows(src,1);
        // clamp destination and adjust for removal
            dst = qBound(0, dst, m_timeItems.rowCount());
        if (src < dst) dst--;
        m_timeItems.insertRow(dst);
        m_timeItems.setData(m_timeItems.index(dst,0), v, Qt::DisplayRole);
    }

void SlideManager::moveResourceToTimeAt(int src, int dst) {
        if (src < 0 || src >= m_resourceItems.rowCount()) return;
        QString v = m_resourceItems.data(m_resourceItems.index(src,0), Qt::DisplayRole).toString();
        m_resourceItems.removeRows(src,1);
        dst = qBound(0, dst, m_timeItems.rowCount());
        if (src < dst) dst--;
        m_timeItems.insertRow(dst);
        m_timeItems.setData(m_timeItems.index(dst,0), v, Qt::DisplayRole);
    }


