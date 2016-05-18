param (
   [string]$filebeat_forwarder = "forwarder.internal.domain.com:9200"
)


$filebeat_dir = "C:\Program Files\Elastic\filebeat"
$filebeat_yml = "$filebeat_dir\filebeat-panic.yml"

Function CreateFilebeatYmlFile {@"
filebeat:
  prospectors:
    -
      paths:
# Watch all the IIS log files on the L: drive
        - L:\*\*.log
        - L:\*\*\*.log
      input_type: log
      document_type: IIS
      exclude_lines: ['^#']
      exclude_files: ['^L:\\Octopus\\.*','^L:\\smtp\\.*']
      ignore_older: 24h
  registry_file: "C:/ProgramData/filebeat/panic-registry"
output:
  logstash:
    hosts: ["$filebeat_forwarder"]
shipper:
logging:
  level: info
  files:
    path: "C:/ProgramData/filebeat/panic-Log"
    rotateeverybytes: 10485760 # = 10MB
"@ | Set-Content $filebeat_yml -encoding UTF8}

cd $filebeat_dir
./filebeat.exe -c $filebeat_yml