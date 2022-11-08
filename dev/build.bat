@echo off
cls

REM Bring this back later
bmp2tile.exe .\gfx\SegaMasterSystemTitleScreen.png -savetiles .\bank1\backgroundtiles.psgcompr -mirror -removedupes -savepalette .\bank1\backgroundpalette.bin -savetilemap .\bank1\backgroundtilemap.bin -exit
bmp2tile.exe .\gfx\man_pal_01.png -nomirror -noremovedupes -savetiles .\bank1\spritetiles.psgcompr -palsms -savepalette .\bank1\spritepalette.bin -exit

REM Banks conversion
cd Banks
REM folder2c bank2 bank2 2
REM Compile banks here...
cd ..

REM This is what I had during working builds
sdcc -c -mz80 --peep-file peep-rules.txt bank1.c
sdcc -c -mz80 --peep-file peep-rules.txt main.c

REM Build main
REM sdcc -c -mz80 --opt-code-speed --peep-file peep-rules.txt --std-c99 main.c

REM Link files
sdcc -o output.ihx --Werror --opt-code-speed -mz80 --no-std-crt0 --data-loc 0xC000 ^
..\crt0\crt0_sms.rel ^
..\lib\SMSlib.lib ^
..\lib\PSGlib.rel

REM Binary output
ihx2sms output.ihx output.sms

REM Copy the file to a more appropriate build folder location later
REM echo Copy output
REM copy output.sms ..\asm
REM copy output.sms ..\MasterBlaster.sms

output.sms