ASSETS = BUILDING.txt \
	Dllmain.c \
	EIComponent.make \
	EIComponentBundle.plc \
	EIComponentSample.def \
	EIComponentSample.dsp \
	EIComponentSample.dsw \
	EIComponent_cw7.mcp \
	EIComponent_cw8.mcp \
	EIComponent_vers.r \
	EI_FormatIncludes \
	EI_GraphicsExport/*.[chr] \
	EI_GraphicsImport/*.[chr] \
	EI_IDs.h \
	EI_ImageCodec/*.[chr] \
	EI_MovieExport/*.[chr] \
	EI_MovieImport/*.[chr] \
	Exports.exp \
	ExportsPB.exp \
	ImportExample.plc \
	ImportExampleTest.c \
	Makefile \
	PrefixIncludes \
	Utilities \
	Xcode/EIComponent.pbproj \
	cw7 \
	cw8 \
	mpw \
	Release/*.txt \
	plist_carb.r \
	version.rc

src : QT-EI-src.zip

QT-EI-src.zip : $(ASSETS)
	rm -f cw[78]/* mpw/*
	zip -9 -r $@ $^ -x `find . -name .DS_Store|cut -c 3-`

