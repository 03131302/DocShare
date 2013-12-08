package com.ocse.doc.domain

class InfoFile {

    static constraints = {
        name nullable: false
        path nullable: false
    }

    static belongsTo = [infoData: InfoData]

    String name
    String path
    Date saveDate
    int state

    Date getSaveDate() {
        return saveDate
    }

    void setSaveDate(Date saveDate) {
        this.saveDate = saveDate
    }

    String getName() {
        return name
    }

    void setName(String name) {
        this.name = name
    }

    String getPath() {
        return path
    }

    void setPath(String path) {
        this.path = path
    }

    int getState() {
        return state
    }

    void setState(int state) {
        this.state = state
    }

    @Override
    public String toString() {
        return "InfoFile{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", path='" + path + '\'' +
                ", saveDate=" + saveDate +
                ", state=" + state +
                ", version=" + version +
                '}';
    }
}
