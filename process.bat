del test-new.csv
set res=F
For /F "usebackq tokens=1-3  delims=," %%a in (infile.csv) Do (
for /f "delims=" %%I in ('powershell -command "(Get-ADUser -Identity %%a).Enabled"') Do ( 
echo.%res%|findstr /C:"F" >nul 2>&1
if not errorlevel 1 (
echo.%%I|findstr /C:"True" >nul 2>&1
if not errorlevel 1 (
   echo %%a,True >> outfile.csv
   set res=T
) else (
    echo %%a,False >> outfile.csv
	set res=T
)
)

)
set res=F
)
START python unique.py