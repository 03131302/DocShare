package com.ocse.doc

import com.artofsolving.jodconverter.DefaultDocumentFormatRegistry
import com.artofsolving.jodconverter.DocumentFamily
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter

/**
 * Created by Administrator on 13-12-15.
 */
class OpenOfficeTool {

    public static void startOffice() {
        String command = "/opt/openoffice4/program/soffice"
        ProcessBuilder pb = new ProcessBuilder(command, "-headless", "-accept=\"socket,host=127.0.0.1,port=8100;urp;\"", "-nofirststartwizard", "&");
        InputStream stderr = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            Process pro = pb.start();
            stderr = pro.getErrorStream();
            isr = new InputStreamReader(stderr, "gbk");
            br = new BufferedReader(isr);
            String line;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
            int exitVal = pro.waitFor();
            System.out.println("PDF服务启动完成: " + exitVal);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stderr != null) {
                    stderr.close();
                }
                if (isr != null) {
                    isr.close();
                }
                if (br != null) {
                    br.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void pdf2swf(String pdfPath, String swfPath) {
        println "开始转换SWF......"
        try {
            pdfPath = pdfPath.replaceAll("\\\\", "/")
            swfPath = swfPath.replaceAll("\\\\", "/")
            String command = "/usr/local/bin/pdf2swf"
            ProcessBuilder pb = new ProcessBuilder(command,
                    "-T", "9", "-f", pdfPath ,
                    "-o", swfPath, "-s", "poly2bitmap");
            InputStream stderr = null;
            InputStreamReader isr = null;
            BufferedReader br = null;
            try {
                Process pro = pb.start();
                stderr = pro.getErrorStream();
                isr = new InputStreamReader(stderr, "gbk");
                br = new BufferedReader(isr);
                String line;
                while ((line = br.readLine()) != null) {
                    System.out.println(line);
                }
                int exitVal = pro.waitFor();
                System.out.println("SWF输出完成: " + exitVal);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (stderr != null) {
                        stderr.close();
                    }
                    if (isr != null) {
                        isr.close();
                    }
                    if (br != null) {
                        br.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace()
        }
    }

    public static File file2PDF(String officeFilePath, String pdfFilePath) {
        officeFilePath = officeFilePath.replaceAll("\\\\", "/")
        pdfFilePath = pdfFilePath.replaceAll("\\\\", "/")
        def input = new File(officeFilePath)
        def output = new File(pdfFilePath)

        println "PDF转换完成：${input.absolutePath}"

        def connection = new SocketOpenOfficeConnection("127.0.0.1", 8100)
        connection.connect()

        try {
            def registry = new DefaultDocumentFormatRegistry()
            def converter = new OpenOfficeDocumentConverter(connection, registry)

            def pdf = registry.getFormatByFileExtension("pdf")
            def pdfOptions = ['ReduceImageResolution': true, 'MaxImageResolution': 30000]
            pdf.setExportOption(DocumentFamily.TEXT, "FilterData", pdfOptions)

            converter.convert(input, output, pdf)
        } catch (Exception e) {
            e.printStackTrace()
        } finally {
            connection.disconnect()
        }
        return output
    }

}