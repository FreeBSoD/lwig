@echo off
;;This is the title of the window
title LWIG Compiler (v0.0.1)
color fc
cls
echo LWIG Assembly Compiler
echo Version v0.0.1 - script by Fariz Luqman - 2fzweb@gmail.com
echo Visit www.lwig.tk for more information.
echo.
echo ========================== Step 1 ==========================
echo.

echo Assembling bootloader...
cd source\bootload
nasm -f bin -o bootload.bin bootload.asm
cd ..

echo Assembling Lwig kernel...
nasm -f bin -o kernel.bin kernel.asm

echo Assembling programs...
cd ..\programs
 for %%i in (*.asm) do nasm -fbin %%i
 for %%i in (*.bin) do del %%i
 for %%i in (*.) do ren %%i %%i.bin
 for %%i in (*.bin) do move %%i %compiled%
 move %lwigboot%\bootload\bootload.bin %bootloader%
 move %lwigboot%\kernel.bin %compiled%
cd ..
echo.
echo Step 1 done, going to step 2.
echo.
echo ========================== Step 2 ==========================
echo.
echo We are going to create your IMG file. Make sure you
echo have installed IMDisk. If not, do that first!
echo When ready, press any key... (Ignore any errors)
pause > nul
echo.
@imdisk -D -m A:
@imdisk -D -m B:
echo.
@imdisk -a -f %yourimgfile%\lwigkernel.img -s 1440K -m B:
echo.
echo Step 2 done, going to step 3.
echo.
echo ========================== Step 3 ==========================
echo.
echo Ok, now, we will copy all your precious works into
echo Folder: %yourimgfile%\lwigkernel.img
echo.
echo Do include your own PCX image file at compiled folder
echo on your virtual disk B: 
echo.
echo If you have .bas (BASIC programs] files, you may include
echo also, and you can just execute it on the LWIG CLi
echo.
echo Press any key to copy files into disk...
pause > nul
echo.
copy compiled\* b:\
echo.
@imdisk -D -m B:
echo.



