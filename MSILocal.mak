#
#    Copyright 1991-2016 Amebis
#    Copyright 2016 GÉANT
#
#    This file is part of GÉANTLink.
#
#    GÉANTLink is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    GÉANTLink is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
#

All ::

CleanSetup ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=$(LANG) PLAT=Win32 CFG=Release
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=$(LANG) PLAT=Win32 CFG=Debug
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=$(LANG) PLAT=x64   CFG=Release
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=$(LANG) PLAT=x64   CFG=Debug
	cd "$(MAKEDIR)"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.msi"  del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.msi" del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.msi"  del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.msi" del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.mst"  del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.mst"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.mst" del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.mst"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.mst"  del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.mst"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.mst" del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.mst"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.2.msi" :: Localization

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.2.msi" :: Localization

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.2.msi" :: Localization

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.2.msi" :: Localization

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Release|Win32"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Debug|Win32"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Release|x64"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Debug|x64"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=$(LANG) PLAT=Win32 CFG=Release
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=$(LANG) PLAT=Win32 CFG=Debug
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=$(LANG) PLAT=x64 CFG=Release
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=$(LANG) PLAT=x64 CFG=Debug
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.sign"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	msiinfo.exe "$(@:"=).tmp" /nologo /U 4
!IFDEF MANIFESTCERTIFICATETHUMBPRINT
	signtool.exe sign /sha1 "$(MANIFESTCERTIFICATETHUMBPRINT)" /t "$(MANIFESTTIMESTAMPURL)" /d "$(MSIBUILD_PRODUCT_NAME)" /q "$(@:"=).tmp"
!ENDIF
	attrib.exe +r "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.sign"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	msiinfo.exe "$(@:"=).tmp" /nologo /U 4
!IFDEF MANIFESTCERTIFICATETHUMBPRINT
	signtool.exe sign /sha1 "$(MANIFESTCERTIFICATETHUMBPRINT)" /t "$(MANIFESTTIMESTAMPURL)" /d "$(MSIBUILD_PRODUCT_NAME)" /q "$(@:"=).tmp"
!ENDIF
	attrib.exe +r "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.sign"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	msiinfo.exe "$(@:"=).tmp" /nologo /U 4
!IFDEF MANIFESTCERTIFICATETHUMBPRINT
	signtool.exe sign /sha1 "$(MANIFESTCERTIFICATETHUMBPRINT)" /t "$(MANIFESTTIMESTAMPURL)" /d "$(MSIBUILD_PRODUCT_NAME)" /q "$(@:"=).tmp"
!ENDIF
	attrib.exe +r "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.sign"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	msiinfo.exe "$(@:"=).tmp" /nologo /U 4
!IFDEF MANIFESTCERTIFICATETHUMBPRINT
	signtool.exe sign /sha1 "$(MANIFESTCERTIFICATETHUMBPRINT)" /t "$(MANIFESTTIMESTAMPURL)" /d "$(MSIBUILD_PRODUCT_NAME)" /q "$(@:"=).tmp"
!ENDIF
	attrib.exe +r "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.mst" : "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.msi"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeMST //Nologo "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32.msi" $@

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.mst" : "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.msi"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeMST //Nologo "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).32D.msi" $@

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.mst" : "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.msi"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeMST //Nologo "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64.msi" $@

"$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.mst" : "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.msi"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeMST //Nologo "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.msi" "$(OUTPUT_DIR)\$(PRODUCT_NAME).$(LANG).64D.msi" $@
