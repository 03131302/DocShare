package com.ocse.doc.domain

class InfoData {

    static constraints = {
        textData nullable: true
        reType nullable: true
    }
    static belongsTo = [type: InfoType, user: AdminUser]
    static mapping = {
        textData sqlType: 'text'
        state defaultValue: 0
    }

    String title
    String shareScope
    String textData
    String saveState
    Date saveDate
    String shareType
    String reType
    int state
    int zhiwu

    String getReType() {
        return reType
    }

    int getZhiwu() {
        return zhiwu
    }

    void setZhiwu(int zhiwu) {
        this.zhiwu = zhiwu
    }

    int getState() {
        return state
    }

    void setState(int state) {
        this.state = state
    }

    void setReType(String reType) {
        this.reType = reType
    }

    String getShareType() {

        return shareType
    }

    void setShareType(String shareType) {
        this.shareType = shareType
    }

    String getTextData() {
        return textData
    }

    void setTextData(String textData) {
        this.textData = textData
    }

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

    String getShareScope() {
        return shareScope
    }

    void setShareScope(String shareScope) {
        this.shareScope = shareScope
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
                ", shareScope='" + shareScope + '\'' +
                ", textData='" + textData + '\'' +
                ", saveState='" + saveState + '\'' +
                ", saveDate=" + saveDate +
                ", shareType='" + shareType + '\'' +
                ", reType='" + reType + '\'' +
                ", state=" + state +
                ", zhiwu=" + zhiwu +
                ", version=" + version +
                '}';
    }
}
