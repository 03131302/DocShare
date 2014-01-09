package com.ocse.doc.domain

class UserCommit {

    static constraints = {
    }

    static belongsTo = [user: AdminUser]

    Date logDate
    String content
    String title

    Date getLogDate() {
        return logDate
    }

    void setLogDate(Date logDate) {
        this.logDate = logDate
    }

    String getContent() {
        return content
    }

    void setContent(String content) {
        this.content = content
    }

    String getTitle() {
        return title
    }

    void setTitle(String title) {
        this.title = title
    }

    @Override
    public String toString() {
        return "UserCommit{" +
                "id=" + id +
                ", logDate=" + logDate +
                ", content='" + content + '\'' +
                ", title='" + title + '\'' +
                ", version=" + version +
                '}';
    }
}
