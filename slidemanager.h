#ifndef SLIDEMANAGER_H
#define SLIDEMANAGER_H

#include <QObject>
#include <slidemodel.h>
#include <QStringListModel>
class SlideManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(SlideModel* model          READ model       CONSTANT)
    Q_PROPERTY(int         currentIndex   READ currentIndex NOTIFY currentIndexChanged)
    Q_PROPERTY(QStringListModel* workItemsModel READ workItemsModel CONSTANT)
    Q_PROPERTY(QStringListModel* resourceItemsModel READ resourceItemsModel CONSTANT)
    Q_PROPERTY(QStringListModel* timeItemsModel READ timeItemsModel CONSTANT)

public:
    explicit SlideManager(QObject *parent = nullptr);
    SlideModel* model(){ return &m_model; }
    int currentIndex() const { return m_currentIndex; }
    QStringListModel* workItemsModel()     { return &m_workItems; }
    QStringListModel* resourceItemsModel() { return &m_resourceItems; }
    QStringListModel* timeItemsModel()     { return &m_timeItems; }

    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();


    //accesibility getters setters
    Q_INVOKABLE int count() const;
    Q_INVOKABLE QString titleAt(int idx) const;
    Q_INVOKABLE QString notesAt(int idx) const;
    Q_INVOKABLE QString dueDateAt(int idx) const;
    Q_INVOKABLE QString componentRoleAt(int idx) const;
    Q_INVOKABLE void    setNotes(int idx, const QString &n);
    Q_INVOKABLE void    setDueDate(int idx, const QString &d);

    //drag and drop

    //Q_INVOKABLE void moveWorkToTime(int idx);
    //Q_INVOKABLE void moveWorkToResource(int idx);
    //Q_INVOKABLE void moveResourceToTime(int idx);
    Q_INVOKABLE void moveWorkToTimeAt(int srcIndex, int dstIndex);
    Q_INVOKABLE void moveResourceToTimeAt(int srcIndex, int dstIndex);

signals:
    void currentIndexChanged();
private:
    SlideModel m_model;
    int m_currentIndex = 0;

    //types can be changed to adapt the data format
    QStringListModel m_workItems;
    QStringListModel m_resourceItems;
    QStringListModel m_timeItems;
};


#endif // SLIDEMANAGER_H
