@echo off
cls

bmp2tile.exe .\gfx\SegaMasterSystemTitleScreen.png -savetiles Banks\bank1\backgroundtiles.psgcompr -mirror -removedupes -savepalette Banks\bank1\backgroundpalette.bin -savetilemap Banks\bank1\backgroundtilemap.bin -exit
bmp2tile.exe .\gfx\man_pal_01.png -nomirror -noremovedupes -savetiles Banks\bank1\spritetiles.psgcompr -palsms -savepalette .\Banks\bank1\spritepalette.bin -exit

bmp2tile.exe .\gfx\SegaMasterSystemTitleScreen.png -savetiles Banks\bank2\backgroundtiles.psgcompr -mirror -removedupes -savepalette Banks\bank2\backgroundpalette.bin -savetilemap Banks\bank2\backgroundtilemap.bin -exit
bmp2tile.exe .\gfx\man_pal_01.png -nomirror -noremovedupes -savetiles Banks\bank2\spritetiles.psgcompr -palsms -savepalette .\Banks\bank2\spritepalette.bin -exit

REM Banks conversion
cd Banks
folder2c bank1 bank1
folder2c bank2 bank2 2

REM Compile banks
sdcc -c --no-std-crt0 -mz80 --Werror --opt-code-speed --constseg BANK1 Banks\bank1.c 
sdcc -c --no-std-crt0 -mz80 --Werror --opt-code-speed --constseg BANK2 Banks\bank2.c 

cd ..

REM Build main
sdcc -c -mz80 --opt-code-speed --peep-file peep-rules.txt --std-c99 main.c

REM Link files
sdcc -o output.ihx -mz80 --Werror ^
 --opt-code-speed ^
 --no-std-crt0 ^
 --data-loc 0xC000 ^
 -Wl-b_BANK1=0x4000 ^
 -Wl-b_BANK2=0x8000 ^
 ..\crt0\crt0_sms.rel main.rel ^
 ..\lib\SMSlib.lib ^
 ..\lib\PSGlib.rel ^
 bank1.rel ^
 Banks\bank2.rel

REM Binary output
ihx2sms output.ihx output.sms

REM Copy the file to a more appropriate build folder location later
REM echo Copy output
REM copy output.sms ..\asm
REM copy output.sms ..\MasterBlaster.sms

output.sms