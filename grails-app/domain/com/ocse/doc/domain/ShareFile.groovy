package com.ocse.doc.domain

class ShareFile {

    static constraints = {
        title nullable: true
        path nullable: true
    }

    Date logDate
    String path
    String title

    Date getLogDate() {
        return logDate
    }

    void setLogDate(Date logDate) {
        this.logDate = logDate
    }

    String getPath() {
        return path
    }

    void setPath(String path) {
        this.path = path
    }

    String getTitle() {
        return title
    }

    void setTitle(String title) {
        this.title = title
    }

    @Override
    public String toString() {
        return "ShareFile{" +
                "id=" + id +
                ", logDate=" + logDate +
                ", path='" + path + '\'' +
                ", title='" + title + '\'' +
                ", version=" + version +
                '}';
    }
}
