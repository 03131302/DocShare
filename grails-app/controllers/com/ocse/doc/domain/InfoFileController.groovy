package com.ocse.doc.domain

import com.ocse.doc.OpenOfficeTool
import grails.transaction.Transactional

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class InfoFileController {

    def fileFormatList = ["pdf", "jpg", "gif", "png", "zip", "rar", "bmp", "exe", "swf", "chm", "7z", "js",
            "xml", "trg", "sql", "cmd", "bat"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InfoFile.list(params), model: [infoFileInstanceCount: InfoFile.count()]
    }

    def line(InfoFile infoFileInstance) {
        response.reset();
        def name = URLEncoder.encode(infoFileInstance.name, "UTF-8");
        response.setHeader("Content-disposition", "attachment; filename=help.swf")
        response.contentType = "application/x-rarx-rar-compressed"
        def webRootDir = servletContext.getRealPath("/") + "upLoad/" + infoFileInstance.path.decodeURL()
        String ext = webRootDir.substring(webRootDir.lastIndexOf(".") + 1, webRootDir.length()).toLowerCase()
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
            if (path != null && !path.empty) {
                def webRootDir = servletContext.getRealPath("/") + "upLoad" + path.decodeURL()
                OpenOfficeTool.startOffice()
                String ext = webRootDir.substring(webRootDir.lastIndexOf(".") + 1, webRootDir.length()).toLowerCase()
                File pdf = new File(webRootDir)
                if (!fileFormatList.contains(ext)) {
                    pdf = OpenOfficeTool.file2PDF(webRootDir, webRootDir + ".pdf")
                }
                if (pdf.exists()) {
                    OpenOfficeTool.pdf2swf(pdf.absolutePath, pdf.absolutePath + ".swf")
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
        }
        render path.encodeAsURL()
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
}
