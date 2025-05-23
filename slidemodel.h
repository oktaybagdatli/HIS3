#ifndef SLIDEMODEL_H
#define SLIDEMODEL_H

#include <QVector>
#include <QAbstractListModel>

//add different ones for each mode maybe
struct SlideItem {
    QString title;
    QString notes;
    QString dueDate;
    QString componentRole;
};

class SlideModel :  public QAbstractListModel{
    Q_OBJECT




public:
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        NotesRole,
        DueDateRole,
        ComponentRole
    };

    explicit SlideModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;


    void addSlide(const SlideItem &slide);
private:
    QVector<SlideItem> m_slides;
};

#endif // SLIDEMODEL_H
