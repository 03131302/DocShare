package com.ocse.doc.domain

import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import com.mongodb.gridfs.GridFSDBFile
import grails.converters.JSON
import grails.transaction.Transactional
import groovy.sql.Sql
import org.apache.commons.codec.digest.DigestUtils
import org.springframework.data.mongodb.core.query.Query
import org.springframework.data.mongodb.gridfs.GridFsCriteria
import org.springframework.data.mongodb.gridfs.GridFsTemplate

import javax.servlet.http.HttpServletResponse
import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.NOT_FOUND

@Transactional(readOnly = true)
class ShareFileController {

    def GridFsTemplate gridFsTemplate

    def grailsApplication

    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 30, 100)
        params.sort = "logDate"
        params.order = "desc"
        render view: "index", model: [shareFileInstanceCount: ShareFile.count(), data: ShareFile.list(params)]
    }

    def show(String id) {
        Sql sql = new Sql(dataSource: dataSource)
        def dataTemp = []
        sql.eachRow("""SELECT [id]
                              ,[path]
                              ,[log_date] logDate
                              ,[title]
                          FROM [DocManage].[dbo].[share_file] where [id]=${id}""") {
            data ->
                dataTemp = [id: data.id, sharefilePathValue: data.path, logDate: data.logDate.format("yyyy-MM-dd"), title: data.title]
        }
        render dataTemp as JSON
    }

    def download(ShareFile shareFileInstance) {
        serverFile(shareFileInstance.path, response)
    }

    public void serverFile(String id, HttpServletResponse response) {
        String objectID = id;
        if (objectID != null) {
            try {
                objectID = URLDecoder.decode(objectID, "UTF-8");
                GridFSDBFile gridFSDBFile = gridFsTemplate.findOne(Query.query(GridFsCriteria.where("md5").is(objectID)));
                if (gridFSDBFile != null) {
                    InputStream inStream = gridFSDBFile.getInputStream();
                    response.setContentType(gridFSDBFile.getContentType());
                    response.addHeader("Content-Disposition", "attachment; filename=\""
                            + new String(((String) (gridFSDBFile.getMetaData().get("fileName"))).getBytes("GB2312"), "iso8859-1") + "\"");
                    byte[] b = new byte[5000];
                    int len;
                    try {
                        while ((len = inStream.read(b)) > 0)
                            response.getOutputStream().write(b, 0, len);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } finally {
                        inStream.close();
                    }
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.flushBuffer();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    def create() {
        respond new ShareFile(params)
    }

    def upload() {
        def url = params.filePath
        def f = request.getFile('Filedata')
        String path = "/";
        def value = [:]
        if (f != null && !f.empty) {
            def webRootDir = servletContext.getRealPath("/")
            def userDir = new File(webRootDir, "/upLoad/")
            if (!userDir.exists()) {
                userDir.mkdirs()
            }
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
            String nd = dateFormat.format(date)
            path += nd;
            dateFormat = new SimpleDateFormat("MM");
            String yd = dateFormat.format(date)
            path += "/" + yd;
            String dir = System.currentTimeMillis();
            path += "/" + dir;
            String temp = "";
            path.split("/").each {
                data ->
                    temp += "/" + data
                    userDir = new File(webRootDir, "/upLoad/" + temp)
                    if (!userDir.exists()) {
                        userDir.mkdirs()
                    }
            }
            path += "/" + f.originalFilename
            File file = new File(userDir, f.originalFilename);
            f.transferTo(file)
            value.put("path", path.encodeAsURL())
            value.put("name", file.name)
            if (Boolean.parseBoolean(grailsApplication.config.mongodb.use)) {
                def data = saveToMongoDB(file.absolutePath, file.name)
                value.put("path", data.hashtext)
                value.put("name", file.name)
            }
        }
        render(contentType: "text/json") { value }
    }

    private boolean isFileExists(String md5) {
        GridFSDBFile gridFSDBFile = gridFsTemplate.findOne(Query.query(GridFsCriteria.where("md5").is(md5)));
        if (gridFSDBFile != null) {
            return true;
        } else {
            return false;
        }
    }

    private Map<String, String> saveToMongoDB(String dest, String fileName) throws IOException {
        BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(dest));
        Map<String, String> resultMap = new LinkedHashMap<String, String>()
        try {
            bufferedInputStream.mark(Integer.MAX_VALUE);
            String hashtext = DigestUtils.md5Hex(bufferedInputStream);
            bufferedInputStream.reset();
            println("计算：" + hashtext);
            if (!isFileExists(hashtext)) {
                DBObject dbObject = new BasicDBObject();
                dbObject.put("fileName", fileName);
                gridFsTemplate.store(bufferedInputStream, dest, "application/octet-stream", dbObject);
                resultMap.put("hashtext", hashtext);
            } else {
                gridFsTemplate.findOne(Query.query(GridFsCriteria.where("md5").is(hashtext)));
                resultMap.put("hashtext", hashtext);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (bufferedInputStream != null) {
                bufferedInputStream.close();
            }
            File tempFile = new File(dest);
            if (tempFile.exists()) {
                tempFile.delete();
            }
        }
        return resultMap
    }

    @Transactional
    def save(ShareFile shareFileInstance) {
        String info = "true";
        try {
            shareFileInstance.path = params.sharefilePathValue
            shareFileInstance.logDate = new Date()
            shareFileInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    def edit(ShareFile shareFileInstance) {
        respond shareFileInstance
    }

    @Transactional
    def update(ShareFile shareFileInstance) {
        String info = "true";
        try {
            shareFileInstance.path = params.sharefilePathValue
            shareFileInstance.logDate = new Date()
            shareFileInstance.save flush: true
        } catch (Exception e) {
            e.printStackTrace()
            info = e.getMessage()
        }
        render info
    }

    @Transactional
    def delete(String id) {
        if (id == null) {
            notFound()
            return
        }
        String info = "true"
        Sql sql = new Sql(dataSource: dataSource)
        id.split(",").each {
            data ->
                try {
                    gridFsTemplate.delete(Query.query(GridFsCriteria.where("md5").is(ShareFile.get(data).path)))
                    sql.execute("delete from [DocManage].[dbo].[share_file] where id=${data}")
                } catch (Exception e) {
                    e.printStackTrace()
                    info = e.getMessage()
                }
        }
        render info
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shareFileInstance.label', default: 'ShareFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
