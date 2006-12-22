# GNU Makefile for Universal Binary QT Component

# toby@telegraphics.com.au, 21 Dec 2006
# See: http://developer.apple.com/technotes/tn/tn2012.html

BUNDLE = EIComponentUB.component
BUNDLEEXEC = ElectricImage
FATBIN  = $(BUNDLE)/Contents/MacOS/$(BUNDLEEXEC)
RSRC = $(BUNDLE)/Contents/Resources/$(BUNDLEEXEC).rsrc

# See: http://developer.apple.com/documentation/Porting/Conceptual/PortingUnix/compiling/chapter_4_section_3.html#//apple_ref/doc/uid/TP40002850-BAJCFEBA
CFLAGS = -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch ppc -arch i386
LDFLAGS = -Wl,-syslibroot,/Developer/SDKs/MacOSX10.4u.sdk -arch ppc -arch i386

CPPFLAGS = -I. -IEI_FormatIncludes -IUtilities \
	-IEI_GraphicsImport -IEI_GraphicsExport -IEI_ImageCodec \
	-IEI_MovieImport -IEI_MovieExport
CFLAGS += -O2 -Wall -Wextra -Wno-parentheses

REZFLAGS = -i . \
	-d TARGET_REZ_MAC_68K=0 \
	-d TARGET_REZ_MAC_PPC=0 \
	-d TARGET_REZ_CARBON_CFM=0 \
	-d TARGET_REZ_CARBON_MACHO=1 \
	-d TARGET_REZ_CARBON_MACHO_X86=1 \
	-d TARGET_REZ_WIN32=0 \
	-d thng_RezTemplateVersion=2

REZFILES = \
	EI_GraphicsImport/EI_GraphicsImport.r \
	EI_GraphicsExport/EI_GraphicsExport.r \
	EI_ImageCodec/EI_ImageCodec.r \
	EI_MovieExport/EI_MovieExport.r \
	EI_MovieExport/EI_MovieExportDialog.r \
	EI_MovieImport/EI_MovieImport.r

OBJ = \
	EI_GraphicsExport/EI_GraphicsExport.o \
	EI_GraphicsImport/EI_GraphicsImport.o \
	EI_ImageCodec/EI_ImageCodec.o \
	EI_MovieExport/EI_MovieExport.o \
	EI_MovieImport/EI_MovieImport.o \
	Utilities/EI_MakeImageDescription.o

$(FATBIN) : ExportsPB.exp $(OBJ) $(BUNDLE) $(RSRC) $(BUNDLE)/Contents/Info.plist
	mkdir -p $(dir $@)
	$(CC) -bundle -o $@ $(OBJ) $(LDFLAGS) -exported_symbols_list ExportsPB.exp \
		-framework Carbon -framework CoreServices -framework QuickTime
	lipo -detailed_info $@

$(BUNDLE) : ; mkdir $@ && /Developer/Tools/SetFile -a B $@

$(BUNDLE)/Contents/Info.plist : Info.plist.in EI_IDs.h
	V=`sed -n -E 's/^.*kEI_VersionShort[[:blank:]]+\"([^"]*)\"/\1/p' EI_IDs.h` ;\
		sed -e s/VERSION_STR/$$V/ $< > $@

$(RSRC) : $(REZFILES) EI_IDs.h
	mkdir -p $(dir $@)
	/Developer/Tools/Rez -o $@ -useDF $(filter %.r,$^) \
		-i /Developer/Headers/FlatCarbon $(REZFLAGS)
	ls -l $@

clean :
	rm -fr $(BUNDLE) $(OBJ)
