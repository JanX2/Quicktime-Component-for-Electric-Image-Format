# Microsoft Developer Studio Project File - Name="ElectricImageWindows" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=ElectricImageWindows - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "EIComponentSample.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "EIComponentSample.mak" CFG="ElectricImageWindows - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ElectricImageWindows - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ElectricImageWindows - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ElectricImageWindows - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir ".\Release"
# PROP BASE Intermediate_Dir ".\Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ".\Release"
# PROP Intermediate_Dir ".\Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MT /W3 /GX /O2 /I "." /I ".\PrefixIncludes" /I ".\EI_FormatIncludes" /I ".\Utilities" /I "c:\QTDevWin\CIncludes" /I "c:\QTDevWin\RIncludes" /I "c:\QTDevWin\ComponentIncludes" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "TARGET_OS_WIN32" /FD /TP /c
# ADD BASE MTL /nologo /D "NDEBUG" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 qtmlclient.lib kernel32.lib user32.lib advapi32.lib /nologo /version:1.4 /subsystem:windows /dll /pdb:none /machine:I386 /nodefaultlib:"libcmtd.lib" /out:".\Release\ElectricImageWindows.dll" /libpath:"c:\QTDevWin\Libraries"
# SUBTRACT LINK32 /verbose /map /nodefaultlib
# Begin Special Build Tool
OutDir=.\Release
TargetName=ElectricImageWindows
SOURCE="$(InputPath)"
PostBuild_Desc=Embedding Mac-style resources into our extension...
PostBuild_Cmds=RezWack -f -d "$(OutDir)\$(TargetName).dll" -r "$(OutDir)\$(TargetName).qtr" -o "$(outDir)\$(TargetName).qtx"	attrib -R "$(outDir)\$(TargetName).qtx"	del "$(OutDir)\$(TargetName).dll"
# End Special Build Tool

!ELSEIF  "$(CFG)" == "ElectricImageWindows - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir ".\Debug"
# PROP BASE Intermediate_Dir ".\Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir ".\Debug"
# PROP Intermediate_Dir ".\Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MTd /W3 /GX /ZI /Od /I "." /I ".\PrefixIncludes" /I ".\EI_FormatIncludes" /I ".\Utilities" /I "c:\QTDevWin\CIncludes" /I "c:\QTDevWin\RIncludes" /I "c:\QTDevWin\ComponentIncludes" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "TARGET_OS_WIN32" /FD /TP /c
# ADD BASE MTL /nologo /D "_DEBUG" /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386
# ADD LINK32 qtmlclient.lib kernel32.lib user32.lib advapi32.lib /nologo /version:1.4 /subsystem:windows /dll /debug /machine:I386 /nodefaultlib:"libcmt.lib" /out:".\Debug\ElectricImageWindows.dll" /libpath:"c:\QTDevWin\Libraries"
# Begin Special Build Tool
OutDir=.\Debug
TargetName=ElectricImageWindows
SOURCE="$(InputPath)"
PostBuild_Desc=Embedding Mac-style resources into our extension...
PostBuild_Cmds=echo on	RezWack -f -d "$(OutDir)\$(TargetName).dll" -r "$(OutDir)\$(TargetName).qtr" -o "$(outDir)\$(TargetName).qtx"	attrib -R "$(outDir)\$(TargetName).qtx"
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "ElectricImageWindows - Win32 Release"
# Name "ElectricImageWindows - Win32 Debug"
# Begin Group "GraphicsImporter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EI_GraphicsImport\EI_GraphicsImport.c
# End Source File
# Begin Source File

SOURCE=.\EI_GraphicsImport\EI_GraphicsImport.r
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\EI_GraphicsImport\EI_GraphicsImportDispatch.h
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "GraphicsExporter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EI_GraphicsExport\EI_GraphicsExport.c
# End Source File
# Begin Source File

SOURCE=.\EI_GraphicsExport\EI_GraphicsExport.r
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\EI_GraphicsExport\EI_GraphicsExportDispatch.h
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "MovieImporter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EI_MovieImport\EI_MovieImport.c
# End Source File
# Begin Source File

SOURCE=.\EI_MovieImport\EI_MovieImport.r
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\EI_MovieImport\EI_MovieImportDispatch.h
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "MovieExporter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EI_MovieExport\EI_MovieExport.c
# End Source File
# Begin Source File

SOURCE=.\EI_MovieExport\EI_MovieExport.r
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\EI_MovieExport\EI_MovieExportDialog.r
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\EI_MovieExport\EI_MovieExportDispatch.h
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "ImageCodec"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EI_ImageCodec\EI_ImageCodec.c
# End Source File
# Begin Source File

SOURCE=.\EI_ImageCodec\EI_ImageCodec.r
# End Source File
# Begin Source File

SOURCE=.\EI_ImageCodec\EI_ImageCodecDispatch.h
# End Source File
# End Group
# Begin Group "Utilities"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Utilities\EI_MakeImageDescription.c
# End Source File
# Begin Source File

SOURCE=.\Utilities\EI_MakeImageDescription.h
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "FormatIncludes"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\EI_FormatIncludes\EI_Image.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\Dllmain.c
# End Source File
# Begin Source File

SOURCE=.\EIComponentSample.def
# End Source File
# Begin Source File

SOURCE=.\PrefixIncludes\EIComponentWindows.r

!IF  "$(CFG)" == "ElectricImageWindows - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Creating Mac-Style Resources
TargetDir=.\Release
TargetName=ElectricImageWindows
InputPath=.\PrefixIncludes\EIComponentWindows.r

"$(TargetDir)\$(TargetName).qtr" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	Rez.exe -rd -i "C:\QTDevWin\RIncludes" -i . -i .\EI_GraphicsImport -i .\EI_GraphicsExport -i .\EI_MovieImport -i .\EI_MovieExport -i .\EI_ImageCodec -o "$(TargetDir)\$(TargetName).qtr" <  "$(InputPath)"

# End Custom Build

!ELSEIF  "$(CFG)" == "ElectricImageWindows - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - Creating Mac-Style Resources
TargetDir=.\Debug
TargetName=ElectricImageWindows
InputPath=.\PrefixIncludes\EIComponentWindows.r

"$(TargetDir)\$(TargetName).qtr" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	Rez.exe -rd -i "C:\QTDevWin\RIncludes" -i . -i .\EI_GraphicsImport -i .\EI_GraphicsExport -i .\EI_MovieImport -i .\EI_MovieExport -i .\EI_ImageCodec -o "$(TargetDir)\$(TargetName).qtr" <  "$(InputPath)"

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\version.rc
# End Source File
# End Target
# End Project
