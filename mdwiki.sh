#!/bin/bash

# Tool to generate simple html wiki from a structure of markdown files.
# Only one sub-folder level is supported. All markdown files need to be in a subfolder.


if [ $# -ne 2 ]; then
	echo "usage: $0 SOURCE_FOLDER DESTINATION_FOLDER"
	exit 1
fi

SOURCE_FOLDER=$1
DESTINATION_FOLDER=$2

TITLE="Wiki"
MARKDOWN="markdown"


# empty destination folder
echo "empty destination: ${DESTINATION_FOLDER}"
rm -rf ${DESTINATION_FOLDER}/*

# prepare index file
INDEX_HTML=${DESTINATION_FOLDER}/index.html
touch ${INDEX_HTML}

printf "<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">\n" >> ${INDEX_HTML}
printf "<html>\n" >> ${INDEX_HTML}
printf "<head>\n" >> ${INDEX_HTML}
printf "<title>${TITLE}</title>\n" >> ${INDEX_HTML}
printf "</head>\n" >> ${INDEX_HTML}
printf "<link rel="stylesheet" type="text/css" href="style.css">\n" >> ${INDEX_HTML}
printf "<body>\n" >> ${INDEX_HTML}

printf "<h1>${TITLE}</h1>\n\n" >> ${INDEX_HTML}

# start processing
echo "start processing in: ${SOURCE_FOLDER}"

# iterate over subdirectories
for dir in ${SOURCE_FOLDER}/*/
do
	# get subdirectory
    dir=${dir%*/}
    dir=${dir##*/}
	echo "  ${dir}"

	# prepare paths
	SOURCE_SUBDIR=${SOURCE_FOLDER}/${dir}
	DEST_SUBDIR=${DESTINATION_FOLDER}/${dir}

	# make subdirectory in destination
	mkdir ${DEST_SUBDIR}

	# insert category in index file
	printf "<h2>${dir}</h2>\n\n" >> ${INDEX_HTML}
	printf "<ul>\n" >> ${INDEX_HTML}

	# iterate over markdown files in subdirectory
	for file in ${SOURCE_SUBDIR}/*.md
	do
		file=${file##*/}
		echo "    ${file}"

		# prepare paths
		SOURCE_FILE=${SOURCE_SUBDIR}/${file}
		DEST_FILE=${DEST_SUBDIR}/${file%.*}.html
		FILE_NAME=${file%.*}
		FILE_LINK=${dir}/${FILE_NAME}.html

		# prepare destination html file
		printf "<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">\n" >> ${DEST_FILE}
		printf "<html>\n" >> ${DEST_FILE}
		printf "<head>\n" >> ${DEST_FILE}
		printf "<title>${FILE_NAME} - ${TITLE}</title>\n" >> ${DEST_FILE}
		printf "</head>\n" >> ${DEST_FILE}
		printf "<link rel="stylesheet" type="text/css" href="../style.css">\n" >> ${DEST_FILE}
		printf "<div id="content">\n" >> ${DEST_FILE}

		# do processing
		${MARKDOWN} ${SOURCE_FILE} >> ${DEST_FILE}

		# close html tags
		printf "</div>\n" >> ${DEST_FILE}
		printf "</html>\n" >> ${DEST_FILE}


		# insert entry in index file
		printf "<li><a href="${FILE_LINK}">${FILE_NAME}</a></li>\n" >> ${INDEX_HTML}
	done

	# close list
	printf "</ul>\n\n" >> ${INDEX_HTML}
done

# close index file
printf "</body>\n" >> ${INDEX_HTML}
printf "</html>\n" >> ${INDEX_HTML}

# copy in style sheet
cp style.css ${DESTINATION_FOLDER}



