#!/bin/bash
#
# Coding test question number 6.  Description:
#
# Assume you have multiple log files within a folder. The content in the log file is 
# being written by an application and is space delimited. 
# The fields are [UTC_TIME CLASS LOG_LEVEL  DESCRIPTION]. An example would be:
# 'Apr 30, 2015 8:27:17 PM org.apache.catalina.core.ApplicationContext log INFO: ContextListener: contextDestroyed()'.
# Write a shell script that can find all log entries in this folder that are of 
# LOG_LEVEL=severe and in between 'Apr 27, 2015 8:00:00 PM' to 'Apr 30, 2015 8:00:00 PM'. 
# Redirect the output of this script to a file .test.txt..
# The file .test.txt. should contains 3 fields viz. name of log file, # of log entries 
# and the actual log entry contents [Don't worry about the formatting]
#
# Ken Treadway - ktreadway@ktreadway.com

# NOTES:
#   - The expected number of entries in each of the mock logfiles:
#	20150426.log  0
#	20150427.log  3
#	20150428.log  4
#	20150429.log  4
#	20150430.log  1
#	20150501.log  0

# Configuration
LOGDIR=logs
START="Apr 27, 2015 8:00:00 PM"
END="Apr 30, 2015 8:00:00 PM"
SEVERITY=SEVERE
OUTPUT=test.txt

# On any uncaught errors, die.
set -e

# Prerequisites - date, cut and wc utilities.
which date >/dev/null 2>&1
which cut >/dev/null 2>&1
which wc >/dev/null 2>&1

# Converts the log file date from text to the UNIX epoch (seconds since 1970-01-01 00:00:00 UTC)
function date_to_epoch {
	date -d"$1" +%s
}

# Checks every line in the logfile ($1) for lines match the specifications:
#   - Between START_EPOCH and END_EPOCH
#   - Severity matches SEVERITY
# Add them to OUTPUT file with leading filename, total count, and log entries.
function parse_logfile {
	local LOGFILE=$1
	local TMP=$(mktemp)
	local LINE=
	
	echo "Reading $LOGFILE..."
	while read LINE; do
		# Grab the time and convert to UNIX epoch.
		# TODO: This is easier in a different language and with a regex, but rules are rules!
		local TIME=$(echo $LINE | cut -d' ' -f1-5)
		local EPOCH=$(date_to_epoch "$TIME")
		
		# Grab the severity and shave the trailing colon.
		local SEV=$(echo $LINE | cut -d' ' -f8 | cut -d':' -f1)
		
		# Check the times.
		if (( EPOCH >= START_EPOCH )) && (( EPOCH <= END_EPOCH)); then
			# Check the severity.
			if [[ "$SEV" == "$SEVERITY" ]]; then
				# Add the line to the temp file.
				echo $LINE >> $TMP
			fi
		fi
	done < $LOGFILE
	
	# If the tempfile has any lines, we need to put this into the output.
	local C=$(wc -l $TMP | cut -d' ' -f1)
	if (( C > 0 )); then
		echo "$C entries found."
		echo $LOGFILE >> $OUTPUT
		echo $C >> $OUTPUT
		cat $TMP >> $OUTPUT
	fi
	
	/bin/rm -f $TMP
}

# Convert the dates into numbers for later comparisons.
START_EPOCH=$(date_to_epoch "$START")
END_EPOCH=$(date_to_epoch "$END")

# Clear previous runs, as needed.
[[ -f $OUTPUT ]] && /bin/rm -f $OUTPUT

# Walk the list of log files and work on them.
for FILE in $LOGDIR/*; do
	parse_logfile $FILE
done
