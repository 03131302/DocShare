grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6

grails.project.fork = [
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    inherits("global") {
    }
    log "info" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        mavenRepo "http://218.29.222.110:8090/nexus/content/groups/public/"
        mavenLocal()
    }

    dependencies {
        runtime 'com.microsoft.sqlserver.jdbc:sqljdbc4:4.0'
    }

    plugins {
        build ":tomcat:7.0.50.1"

        compile ":scaffolding:2.0.1"
        compile ':cache:1.1.1'

        runtime ":hibernate4:4.1.11.4"
        compile ":jcaptcha:1.2.1"
        compile ":excel-export:0.1.10"
        runtime ":database-migration:1.3.8"
        runtime ":jquery:1.10.2"
        runtime ":resources:1.2.1"
    }
}
