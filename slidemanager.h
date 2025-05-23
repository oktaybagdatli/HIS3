#ifndef SLIDEMANAGER_H
#define SLIDEMANAGER_H

#include <QObject>
#include <slidemodel.h>

class SlideManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(SlideModel* model          READ model       CONSTANT)
    Q_PROPERTY(int         currentIndex   READ currentIndex NOTIFY currentIndexChanged)
public:
    explicit SlideManager(QObject *parent = nullptr);
    SlideModel* model(){ return &m_model; }
    int currentIndex() const { return m_currentIndex; }

    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();

    Q_INVOKABLE int count() const;
    Q_INVOKABLE QString titleAt(int idx) const;
    Q_INVOKABLE QString notesAt(int idx) const;
    Q_INVOKABLE QString dueDateAt(int idx) const;
    Q_INVOKABLE QString componentRoleAt(int idx) const;
    Q_INVOKABLE void    setNotes(int idx, const QString &n);
    Q_INVOKABLE void    setDueDate(int idx, const QString &d);


signals:
    void currentIndexChanged();
private:
    SlideModel m_model;
    int m_currentIndex = 0;
};


#endif // SLIDEMANAGER_H
