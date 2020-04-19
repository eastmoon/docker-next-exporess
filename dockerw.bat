@rem
@rem Copyright 2019 the original author jacky.eastmoon
@rem
@rem setting batch file
@rem ref : https://www.tutorialspoint.com/batch_script/batch_script_if_else_statement.htm
@rem ref : https://poychang.github.io/note-batch/
@echo off
setlocal
setlocal enabledelayedexpansion

@rem retrieve container name
@rem Ref : https://www.robvanderwoude.com/ntfor.php
for %%a in ("%cd%") do (
    set container=%%~na
)

@rem declare variable
set env=dev

:cli
for %%p in (%*) do (
    if "%%p"=="-h" goto help
    if "%%p"=="--help" goto help
    if "%%p"=="--prod" set env=prod
    if "%%p"=="up" (
        goto docker-compose-up
    )
    if "%%p"=="down" (
        goto docker-compose-down
    )
)
goto help

:help
echo This is a docker control script with project %container%
echo If not input any command, at default will
echo.
echo Options:
echo      --prod            Set with Production environment.
echo.
echo Command:
echo      up                Startup container with docker-compose.
echo      down              Close down all container with docker-compose.
echo.
echo Run 'dockerw COMMAND --help' for more information on a command.
goto end

:docker-prepare
@rem Create .env for docker-compose
echo Current Environment %env%
echo TAG=%container% > .env

@rem Build docker image by dockerfile
docker build --rm -t mongo:%container% ./docker/dockerfile/mongo
docker build --rm -t node:%container% ./docker/dockerfile/node
EXIT /B 0

:docker-compose-up
call :docker-prepare

@rem Startup docker container instance by docker-compose
docker-compose -f ./docker/docker-compose-%env%.yml up -d
if "%env%"=="dev" (
    @rem Run next deveopment with stdout
    docker exec -ti node_service_%container% bash -l -c "cd /repo && yarn install && yarn development"
)
goto end

:docker-compose-down
@rem Close docker container instance by docker-compose
docker-compose -f ./docker/docker-compose-%env%.yml down
goto end

:end
endlocal
