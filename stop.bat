@echo off
setlocal
set "CURRENT_DIR=%~dp0"
set "CATALINA_HOME=%CURRENT_DIR%tomcat"
if "%JAVA_HOME%"=="" (
    set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot"
)
call "%CATALINA_HOME%\bin\catalina.bat" stop
echo Server stopped.
