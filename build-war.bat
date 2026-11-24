@echo off
setlocal
echo ========================================================
echo Building Mindet Self-Contained WAR (ROOT.war)
echo ========================================================
set "CURRENT_DIR=%~dp0"
if "%JAVA_HOME%"=="" (
    set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-21.0.12.101-hotspot"
)
set "JAVAC=%JAVA_HOME%\bin\javac.exe"
set "JAR=%JAVA_HOME%\bin\jar.exe"

echo 1. Compiling Java sources...
if not exist "%CURRENT_DIR%src\main\webapp\WEB-INF\classes" mkdir "%CURRENT_DIR%src\main\webapp\WEB-INF\classes"
set "CP=%CURRENT_DIR%tomcat\lib\*"

for /f "delims=" %%i in ('dir /s /b "%CURRENT_DIR%src\main\java\*.java"') do set "JAVA_FILES=!JAVA_FILES! "%%i""
"%JAVAC%" -encoding UTF-8 -cp "%CP%" -d "%CURRENT_DIR%src\main\webapp\WEB-INF\classes" "%CURRENT_DIR%src\main\java\com\mindet\model\*.java" "%CURRENT_DIR%src\main\java\com\mindet\util\*.java" "%CURRENT_DIR%src\main\java\com\mindet\dao\*.java" "%CURRENT_DIR%src\main\java\com\mindet\filter\*.java" "%CURRENT_DIR%src\main\java\com\mindet\servlet\*.java"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed!
    exit /b %ERRORLEVEL%
)

echo 2. Packaging ROOT.war...
pushd "%CURRENT_DIR%src\main\webapp"
"%JAR%" -cvf "%CURRENT_DIR%ROOT.war" *
popd

echo ========================================================
echo ROOT.war successfully built! Ready for deployment.
echo ========================================================
