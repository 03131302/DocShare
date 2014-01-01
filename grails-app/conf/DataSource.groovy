dataSource {
    pooled = true
    driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    username = dataSource.username
    password = dataSource.password
    loggingSql = true
    dialect = org.hibernate.dialect.SQLServer2008Dialect
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory'
}

environments {
    development {
        dataSource {
            dbCreate = ""
            url = dataSource.url
            properties {
                maxActive = -1
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                validationQuery = "SELECT 1"
                jdbcInterceptors = "ConnectionState"
            }
        }
    }
    test {
        dataSource {
            dbCreate = ""
            url = dataSource.url
            properties {
                maxActive = -1
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                validationQuery = "SELECT 1"
                jdbcInterceptors = "ConnectionState"
            }
        }
    }
    production {
        dataSource {
            dbCreate = ""
            url = dataSource.url
            properties {
                maxActive = -1
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                validationQuery = "SELECT 1"
                jdbcInterceptors = "ConnectionState"
            }
        }
    }
}