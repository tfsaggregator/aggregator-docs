cd %~dp0

:: GENERATE
REM HACK see npm issue #2938
call npm run index
hugo --ignoreCache --noChmod --verbose
goto quit

:: PUBLISH
cd public
git add -A
git commit -m "Site rebuilt locally"
git push origin master
cd ..

:quit