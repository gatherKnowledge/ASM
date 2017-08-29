set mPath=%1
:compile
"C:\Program Files\NASM\nasm.exe" %mPath%.asm -f bin -o %mPath%.bin
@echo =======================================================================
set /p yn=Keep going Or Stop(Y/N) ?
if "n" == "%yn%" (
goto end
)
"C:\Program Files\qemu\qemu-system-x86_64.exe" -L . -boot c -m 256 -hda "C:\Asm\%mPath%.bin"  -soundhw all -localtime -M pc
goto end

rem @echo set /p yn=Do you want to recompile?(Y/N)
rem if "y" == "%yn%" (
rem     goto compile
rem )
rem if "" == "%yn%" (
rem     goto compile
rem )

:end
    @echo **********************END**********************
    cls
