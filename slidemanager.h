#ifndef SLIDEMANAGER_H
#define SLIDEMANAGER_H

#include <QObject>
#include <slidemodel.h>
#include <QStringListModel>
#define NB_MODES 3
class SlideManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int         currentIndex   READ currentIndex NOTIFY currentIndexChanged)
    Q_PROPERTY(QStringListModel* workItemsModel READ workItemsModel CONSTANT)
    Q_PROPERTY(QStringListModel* resourceItemsModel READ resourceItemsModel CONSTANT)
    Q_PROPERTY(QStringListModel* timeItemsModel READ timeItemsModel CONSTANT)

public:
    explicit SlideManager(QObject *parent = nullptr);

    int currentIndex() const { return m_currentIndex; }
    QStringListModel* workItemsModel()     { return &m_workItems; }
    QStringListModel* resourceItemsModel() { return &m_resourceItems; }
    QStringListModel* timeItemsModel()     { return &m_timeItems; }

    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();




    //drag and drop

    //Q_INVOKABLE void moveWorkToTime(int idx);
    //Q_INVOKABLE void moveWorkToResource(int idx);
    //Q_INVOKABLE void moveResourceToTime(int idx);
    Q_INVOKABLE void moveWorkToTime(int srcIndex);
    Q_INVOKABLE void moveResourceToTime(int srcIndex);

signals:
    void currentIndexChanged();
private:

    int m_currentIndex = 0;

    //types can be changed to adapt the data format
    QStringListModel m_workItems;
    QStringListModel m_resourceItems;
    QStringListModel m_timeItems;
};


#endif // SLIDEMANAGER_H
