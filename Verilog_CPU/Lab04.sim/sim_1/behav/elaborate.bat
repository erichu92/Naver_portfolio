@echo off
set xv_path=E:\\vivado\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto ed579eaba8744944ac299fbf4228b378 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_cpu_behav xil_defaultlib.tb_cpu xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
