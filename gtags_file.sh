#!/bin/sh
# generate tag file for lookupfile plugin
echo "test source"
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > gtags_files
#find . -not -regex '.*\.\(png\|gif\|pbi\|o\|out\|cout\|html\|pack\|idx\)' \
#	   -not -path "./.git/*" \
#	   -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags

# -path "./Documentation*" -prune -o \
# -name "*.[chxsS]" -print > cscope.files
find . \
	-path "./.git/*" -prune -o \
	-path "./arch/*" ! -path "./arch/arm*" -prune -o \
	-path "./drivers*" -prune -o \
	-path "./firmware*" -prune -o \
	-path "./usr*" -prune -o \
	-path "./samples*" -prune -o \
	-path "./scripts*" -prune -o \
	-path "./sound*" -prune -o \
	-path "./tmp*" -prune -o \
	-path "./tools*" -prune -o \
	-print > gtags_files
