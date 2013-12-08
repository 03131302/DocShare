package com.ocse.doc.domain

class InfoData {

    static constraints = {
    }
    static belongsTo = [type: InfoType, user: AdminUser]
    static mapping = {
        text sqlType: 'text'
    }

    String title
    String shareType
    String shareScope
    String text
    String saveState
    Date saveDate

    String getTitle() {
        return title
    }

    Date getSaveDate() {
        return saveDate
    }

    void setSaveDate(Date saveDate) {
        this.saveDate = saveDate
    }

    void setTitle(String title) {
        this.title = title
    }

    String getShareType() {
        return shareType
    }

    void setShareType(String shareType) {
        this.shareType = shareType
    }

    String getShareScope() {
        return shareScope
    }

    void setShareScope(String shareScope) {
        this.shareScope = shareScope
    }

    String getText() {
        return text
    }

    void setText(String text) {
        this.text = text
    }

    String getSaveState() {
        return saveState
    }

    void setSaveState(String saveState) {
        this.saveState = saveState
    }

    @Override
    public String toString() {
        return "InfoData{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", shareType='" + shareType + '\'' +
                ", shareScope='" + shareScope + '\'' +
                ", text='" + text + '\'' +
                ", saveState='" + saveState + '\'' +
                ", saveDate=" + saveDate +
                ", version=" + version +
                ", type=" + type +
                ", user=" + user +
                '}';
    }
}
