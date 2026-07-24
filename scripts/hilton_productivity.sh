#! /bin/bash

DATE_SHORT=$(date +%d_%m_%y)
DATE=$(date +%d_%m_%y)
INPUT_FILE="../input/employee_${DATE_SHORT}.csv"
OUTPUT_FILE="../output/Emp_Productivity_${DATE}.dat"
LOG_FILE="../logs/logs_${DATE}.log"
echo "Process Started $(date)" >> $LOG_FILE

# File Exists

if [ ! -f "$INPUT_FILE" ]
then
  echo "ERROR : Input filenot recieved before 3:00 AM IST" >> $LOG_FILE
  echo "Alert Email Triggered : File Missing" >> $LOG_FILE
  echo "Process Ended : $(date)" >> $LOG_FILE
  exit 1
fi

# File delay Check

FILE_TIME=$(stat -c %Y "$INPUT_FILE")
CURRENT_TIME=$(date +%s)
if [ $FILE_TIME -gt $CURRENT_TIME ]
then
  echo "ERROR : File Recived Late" >> $LOG_FILE
  echo "Alert Email Triggeered : Delayed File" >> $LOG_FILE
  echo "Process Ended : $(date)"  >> $LOG_FILE
  exit 1
fi

echo "File Arrival Validation Successful" >> $LOG_FILE

# Header Validation

EXPECTED_HEADER="EmployeeID,EMployeeName,Phone,Email,InTime,TotalHours"
HEADER=$(head -n 1 "$INPUT_FILE")
if [ "$HEADER" != "$EXPECTED_HEADER" ]
then
  echo "ERROR : Invalid file format" >> $LOG_FILE
  echo "Expected Header :" >> $LOG_FILE
  echo "$EXPECTED_HEADER" >> $LOG_FILE
  echo "Process Ended : $(date)" >> $LOG_FILE
  exit 1
fi
echo "Format Validation Successful" >> $LOG_FILE

#Empty file validation

REOCRD_COUNT=$(tail -n +2 "$INPUT_FILE" \ wc -l)
if [ $REOCRD_COUNT -eq 0 ]
then
  echo "WARNING : file contains header only" >> $LOG_FILE
  echo "Zero records available to process" >> $LOG_FILE
  echo "Process Ended : $(date)" >> $LOG_FILE
  exit 1
fi
echo "Employee records found : $REOCRD_COUNT" >> $LOG_FILE

#Create output file

echo "Generating output file..." >> $LOG_FILE

# Write output data

tail -n +2 "$INPUT_FILE" | while IFS=',' \
read EMP_ID EMP_NAME PHONE EMAIL INTIME TOTAL_HOURS
do
  echo "${EMP_ID}|${EMP_NAME}|${EMAIL}|${TOTAL_HOURS}" \ >> "$OUTPUT_FILE"
done
echo "Ouput file created Succeessfully" >> $LOG_FILE

#Productivity Calculation

TOTAL_EMPLOYEES=0
TOTAL_MINUTES=0

while IFS=',' \
read EMP_ID EMP_NAME PHONE EMAIL INTIME TOTAL_HOURS
do
    if [ "$EMP_ID" != "EmployeeID" ]
    then
      TOTAL_EMPLOYEES=$((TOTAL_EMPLOYEE+1))

      HOURS=$(ECHO "$TOTAL_HOURS" | cut -d':' -f1)
      MINUTES=$(echo "$TOTAL_MINUTES" | cut -d':' -f2)
      TOTAL_MINUTES=$((TOTAL_MINUTES + HOURS*60 + MINUTES))
done < "$INPUT_FILE"

FINAL_HOURS=$((TOTAL_MINUTES / 60))
FINAL_MINUTES=$((TOTAL_MINUTES % 60))

#sUMMARY

SUMMARY="Total Employees Count : $TOTAL_EMPLOYEES
Productivity of the day : ${FINAL_HOURS}:$(printf "%02d" $FINAL_MINUTES):00"
echo "$SUMMARY"
echo "$SUMMARY" >> $LOG_FILE

echo "Productivity of the day successfully written into file" \ >> $LOG_FILE

#Email Notification

echo "Summary Email Triggered" >> $LOG_FILE

# API Call

echo "Triggered Spring Boot API..." >> $LOG_FILE
RESPONSE=$(curl -s -X POST \ "http://localhost:8080/loadEmplyeeData?fileName=$OUTPUT_FILE")
echo "API Response : $RESPONSE" >> $LOG_FILE

# FINAL LOGGING

echo "SUCCESS : DAT File Created" >> $LOG_FILE
echo "SUCCESS : Data Loaded into database" >> $LOG_FILE
echo "Process completed successfuly" >> $LOG_FILE
echo "Process Ended : $(date)" >> $LOG_FILE
echo "============================================" >> $LOG_FILE
