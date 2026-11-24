@echo off
setlocal
echo ========================================================
echo Starting Mindet JSP Application (Jakarta Server Pages)
echo ========================================================
set "CURRENT_DIR=%~dp0"
set "CATALINA_HOME=%CURRENT_DIR%tomcat"
if "%JAVA_HOME%"=="" (
    set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot"
)
echo CATALINA_HOME: %CATALINA_HOME%
echo JAVA_HOME: %JAVA_HOME%
echo.
echo Application will be available at: http://localhost:8080/
echo Press Ctrl+C to stop the server.
echo ========================================================
call "%CATALINA_HOME%\bin\catalina.bat" run
