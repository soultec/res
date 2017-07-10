@echo off

    rem setup variables specific to project
    set debug=1
    set color_mode=0a
    set drive=C:
    set dir_ruby=C:\Ruby23-x64
    set dir_workspace=C:\user\workspace\projektXYZ
    set dir_resources=res
    set dir_compilationfiles=%dir_resources%\compile
    set dir_scss=%dir_resources%\scss
    set dir_css=%dir_resources%\css
    set dir_img=%dir_resources%\img
    set dir_js=%dir_resources%\js
    set name_main_js_file=main

    rem change directory to workspace path abd set color mode
    %drive%
    cd %dir_workspace%
    color %color_mode%

    :START

    rem compile scss folder
    echo ----------------------------
    echo ...compile scss folder...
    @"%dir_ruby%\bin\ruby.exe" "%dir_ruby%\bin\compass" compile "%dir_workspace%" --sass-dir "%dir_scss%" --css-dir "%dir_css%" --javascripts-dir "%dir_js%" --images-dir "%dir_img%" --no-line-comments
    echo ----------------------------

    echo.

    rem minify css
    echo ----------------------------
    echo ...minifying css...
    java -jar %dir_compilationfiles%\yuicompressor-2.4.8.jar %dir_css%\mobile.css -o %dir_css%\mobile.min.css
    java -jar %dir_compilationfiles%\yuicompressor-2.4.8.jar %dir_css%\print.css -o %dir_css%\print.min.css
    java -jar %dir_compilationfiles%\yuicompressor-2.4.8.jar %dir_css%\screen.css -o %dir_css%\screen.min.css
    echo ----------------------------

    echo.

    rem minify js (if debug mode is on, just copy source js file)
    if /i %debug%==1 (
        echo ----------------------------
        echo ...copying source js file as minified file without minifying...
        xcopy /Y %dir_js%\%name_main_js_file%.js %dir_js%\%name_main_js_file%.min.js
        echo ----------------------------
    ) else (
        echo ----------------------------
        echo ...minifying js...
        java -jar %dir_compilationfiles%\yuicompressor-2.4.8.jar %dir_js%\%name_main_js_file%.js -o %dir_js%\%name_main_js_file%.min.js
        echo ----------------------------
    )

    echo.

    echo -------------------- hit any key to re run --------------------
    echo.
    echo.
    echo.

    pause > nul
    goto :START