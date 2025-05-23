#include "slidemodel.h"

SlideModel::SlideModel(QObject *parent) : QAbstractListModel(parent) {
}

int SlideModel::rowCount(const QModelIndex &)const{
    return m_slides.size();
}
QVariant SlideModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_slides.size())
        return QVariant();

    const auto &s = m_slides.at(index.row());
    switch (role) {
    case TitleRole:      return s.title;
    case NotesRole:      return s.notes;
    case DueDateRole:    return s.dueDate;
    case ComponentRole:  return s.componentRole;
    default:             return QVariant();
    }
}

bool SlideModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    if (!index.isValid() || index.row() >= m_slides.size())
        return false;;
    auto &s = m_slides[index.row()];
    switch (role) {
    case NotesRole:    s.notes    = value.toString(); break;
    case DueDateRole:  s.dueDate  = value.toString(); break;
    default: return false;
    }
    emit dataChanged(index, index, {role});
    return true;
}

Qt::ItemFlags SlideModel::flags(const QModelIndex &index) const {
    if (!index.isValid()) return Qt::NoItemFlags;
    return Qt::ItemIsSelectable | Qt::ItemIsEnabled | Qt::ItemIsEditable;
}

QHash<int, QByteArray> SlideModel::roleNames() const {
    return {
        { TitleRole,      "title"       },
        { NotesRole,      "notes"       },
        { DueDateRole,    "dueDate"     },
        { ComponentRole,  "componentRole"}
    };
}

void SlideModel::addSlide(const SlideItem &slide) {
    beginInsertRows(QModelIndex(), m_slides.size(), m_slides.size());
    m_slides.append(slide);
    endInsertRows();
}


