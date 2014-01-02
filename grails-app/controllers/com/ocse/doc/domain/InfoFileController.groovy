package com.ocse.doc.domain

import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import com.mongodb.gridfs.GridFSDBFile
import com.mongodb.gridfs.GridFSFile
import grails.transaction.Transactional
import org.apache.commons.codec.digest.DigestUtils
import org.springframework.data.mongodb.core.query.Query
import org.springframework.data.mongodb.gridfs.GridFsCriteria
import org.springframework.data.mongodb.gridfs.GridFsTemplate

import javax.servlet.http.HttpServletResponse
import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class InfoFileController {

    def GridFsTemplate gridFsTemplate

    def grailsApplication

    def fileFormatList = ["pdf", "jpg", "gif", "png", "zip", "rar", "bmp", "exe", "swf", "chm", "7z", "js",
            "xml", "trg", "sql", "cmd", "bat"]

    def officeSWFToolService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoFile.list(params), model: [infoFileInstanceCount: InfoFile.count()]
    }

    //SWF在线显示
    def line(InfoFile infoFileInstance) {
        response.reset();
        def name = URLEncoder.encode(infoFileInstance.name, "UTF-8");
        response.setHeader("Content-disposition", "attachment; filename=help.swf")
        response.contentType = "application/x-rarx-rar-compressed"

        def webRootDir = servletContext.getRealPath("/") + "upLoad/" + infoFileInstance.path.decodeURL()


        if (Boolean.parseBoolean(grailsApplication.config.mongodb.use)) {
            GridFSDBFile gridFSDBFile = gridFsTemplate.findOne(Query.query(GridFsCriteria.where("md5").is(infoFileInstance.path)));
            if (gridFSDBFile != null) {
                webRootDir = servletContext.getRealPath("/")
                def userDir = new File(webRootDir, "/upLoad/")
                def pathTemp = userDir.absolutePath + "/"
                Date date = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
                String nd = dateFormat.format(date)
                pathTemp += nd;
                dateFormat = new SimpleDateFormat("MM");
                String yd = dateFormat.format(date)
                pathTemp += "/" + yd;
                pathTemp += "/" + (String) (gridFSDBFile.getMetaData().get("fileName"))
                println pathTemp
                File t = new File(pathTemp)
                if (t.exists()) {
                    t.delete()
                }
                webRootDir = pathTemp
            }
        }


        String ext = webRootDir.substring(webRootDir.lastIndexOf(".") + 1, webRootDir.length()).toLowerCase()
        println("在线显示：" + webRootDir)
        def userDir
        if (!fileFormatList.contains(ext)) {
            userDir = new File("${webRootDir}.pdf.swf")
        } else {
            userDir = new File("${webRootDir}.swf")
        }
        def out = response.outputStream
        def inputStream = new FileInputStream(userDir)
        try {
            byte[] buffer = new byte[1024]
            int i = -1
            while ((i = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, i)
            }
            out.flush()
        } catch (Exception e) {
            e.printStackTrace()
        } finally {
            if (out != null) {
                out.close()
            }
            if (inputStream != null) {
                inputStream.close()
            }
        }
    }

    def showOnLine(InfoFile infoFileInstance) {
        String pathData = ""
        if (infoFileInstance != null) {
            String path = infoFileInstance.path

            if (Boolean.parseBoolean(grailsApplication.config.mongodb.use)) {
                GridFSDBFile gridFSDBFile = gridFsTemplate.findOne(Query.query(GridFsCriteria.where("md5").is(path)));
                if (gridFSDBFile != null) {
                    def webRootDir = servletContext.getRealPath("/")
                    def userDir = new File(webRootDir, "/upLoad/")
                    if (!userDir.exists()) {
                        userDir.mkdirs()
                    }
                    def pathTemp = userDir.absolutePath + "/"
                    Date date = new Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
                    String nd = dateFormat.format(date)
                    pathTemp += nd;
                    dateFormat = new SimpleDateFormat("MM");
                    String yd = dateFormat.format(date)
                    pathTemp += "/" + yd;
                    String temp = "";
                    pathTemp.split("/").each {
                        data ->
                            temp += "/" + data
                            userDir = new File(webRootDir, "/upLoad/" + temp)
                            if (!userDir.exists()) {
                                userDir.mkdirs()
                            }
                    }
                    pathTemp += "/" + (String) (gridFSDBFile.getMetaData().get("fileName"))
                    println pathTemp
                    File t = new File(pathTemp)
                    if (t.exists()) {
                        t.delete()
                    }
                    gridFSDBFile.writeTo(pathTemp)
                    path = pathTemp
                }
            }

            if (path != null && !path.empty) {
                def webRootDir = servletContext.getRealPath("/") + "upLoad" + path.decodeURL()
                if (Boolean.parseBoolean(grailsApplication.config.mongodb.use)) {
                    webRootDir = path
                }
                officeSWFToolService.startOffice()
                String ext = webRootDir.substring(webRootDir.lastIndexOf(".") + 1, webRootDir.length()).toLowerCase()
                File pdf = new File(webRootDir)
                if (!fileFormatList.contains(ext)) {
                    pdf = officeSWFToolService.file2PDF(webRootDir, webRootDir + ".pdf")
                }
                if (pdf.exists() && pdf.canRead()) {
                    officeSWFToolService.pdf2swf(pdf.absolutePath, pdf.absolutePath + ".swf")
                }
                //日志记录
                try {
                    InfoLog infoLog = new InfoLog(infoData: infoFileInstance.infoData,
                            user: session["adminUser"], infoDate: new Date()
                            , ip: request.getRemoteAddr(), type: "在线浏览")
                    infoLog.save flush: true
                } catch (Exception e) {
                    e.printStackTrace()
                }
                File swf = new File(pdf.absolutePath + ".swf")
                if (swf.exists()) {
                    pathData = "upLoad/" + path.decodeURL() + ".pdf.swf"
                    render view: "index", model: [path: pathData, infoFileInstance: infoFileInstance]
                    return false
                } else {
                    respond(controller: "infoFile", action: show(infoFileInstance))
                    return false
                }
            }
        }
        render view: "index", model: [path: pathData, infoFileInstance: infoFileInstance]
    }

    def show(InfoFile infoFileInstance) {
        if (Boolean.parseBoolean(grailsApplication.config.mongodb.use)) {
            serverFile(infoFileInstance.path, response)
        } else {
            dowloadFileLocal(infoFileInstance)
        }
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

    private void dowloadFileLocal(InfoFile infoFileInstance) {
        response.reset();
        def name = URLEncoder.encode(infoFileInstance.name, "UTF-8");
        response.setHeader("Content-disposition", "attachment; filename=${name}")
        response.contentType = "application/x-rarx-rar-compressed"
        def webRootDir = servletContext.getRealPath("/")
        def userDir = new File(webRootDir, "/upLoad/${infoFileInstance.path.decodeURL()}")
        println userDir.absolutePath
        def out = response.outputStream
        def inputStream = new FileInputStream(userDir)
        try {
            byte[] buffer = new byte[1024]
            int i = -1
            while ((i = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, i)
            }
            out.flush()
        } catch (Exception e) {
            e.printStackTrace()
        } finally {
            if (out != null) {
                out.close()
            }
            if (inputStream != null) {
                inputStream.close()
            }
        }
    }

    def create() {
        respond new InfoFile(params)
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

    @Transactional
    def save(InfoFile infoFileInstance) {
        if (infoFileInstance == null) {
            notFound()
            return
        }

        if (infoFileInstance.hasErrors()) {
            respond infoFileInstance.errors, view: 'create'
            return
        }

        infoFileInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'infoFileInstance.label', default: 'InfoFile'), infoFileInstance.id])
                redirect infoFileInstance
            }
            '*' { respond infoFileInstance, [status: CREATED] }
        }
    }

    def edit(InfoFile infoFileInstance) {
        respond infoFileInstance
    }

    @Transactional
    def update(InfoFile infoFileInstance) {
        if (infoFileInstance == null) {
            notFound()
            return
        }

        if (infoFileInstance.hasErrors()) {
            respond infoFileInstance.errors, view: 'edit'
            return
        }

        infoFileInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InfoFile.label', default: 'InfoFile'), infoFileInstance.id])
                redirect infoFileInstance
            }
            '*' { respond infoFileInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(InfoFile infoFileInstance) {

        if (infoFileInstance == null) {
            notFound()
            return
        }

        infoFileInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'InfoFile.label', default: 'InfoFile'), infoFileInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'infoFileInstance.label', default: 'InfoFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
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
                GridFSFile gridFSFile = gridFsTemplate.store(bufferedInputStream, dest, "application/octet-stream", dbObject);
                resultMap.put("hashtext", hashtext);
            } else {
                GridFSDBFile gridFSDBFile = gridFsTemplate.findOne(Query.query(GridFsCriteria.where("md5").is(hashtext)));
                String id = gridFSDBFile.getFilename();
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
}
