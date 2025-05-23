#include "slidemanager.h"
#include <QModelIndex>
#include <iostream>

SlideManager::SlideManager(QObject *parent)
    : QObject(parent)
{
    m_model.addSlide({ "Work",       "", "", "work" });
    m_model.addSlide({ "Ressources", "", "", "resources" });
    m_model.addSlide({ "Time",       "", "", "time" });
}


int SlideManager::count() const{
    return m_model.rowCount();
}
void SlideManager::next() {
    m_currentIndex = (m_currentIndex+1) % m_model.rowCount();
    emit currentIndexChanged();
}

void SlideManager::previous() {
    m_currentIndex = (m_currentIndex-1 + m_model.rowCount()) % m_model.rowCount();
    emit currentIndexChanged();
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



