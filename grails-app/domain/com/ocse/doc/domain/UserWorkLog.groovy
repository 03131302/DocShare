package com.ocse.doc.domain

class UserWorkLog {

    static constraints = {
        title nullable: true
        content nullable: true
    }

    static belongsTo = [user: AdminUser]

    Date logDate
    String content
    String title

    String getTitle() {
        return title
    }

    void setTitle(String title) {
        this.title = title
    }

    String getContent() {
        return content
    }

    void setContent(String content) {
        this.content = content
    }

    Date getLogDate() {
        return logDate
    }

    void setLogDate(Date logDate) {
        this.logDate = logDate
    }

    @Override
    public String toString() {
        return "UserWorkLog{" +
                "id=" + id +
                ", logDate=" + logDate +
                ", content='" + content + '\'' +
                ", title='" + title + '\'' +
                ", version=" + version +
                ", user=" + user +
                '}';
    }
}
