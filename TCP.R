#announce libraries
library(tidyr)
library(dplyr)
library(data.table)
#choose the csv file that interests your
data <- read.table(file = file.choose(), header = TRUE, sep = ",")
#create selection exclusively by TCP protocol
tcp_table <- subset(data, Protocol == "TCP", select = c(Protocol, Source, Destination))
#identify a couple of addresses that use the TCP protocol the most times
tcp_table <- data.table::data.table(count(group_by(tcp_table, Protocol, Source, Destination)))
# sorting
tcp_table<-dplyr::arrange(tcp_table, desc (tcp_table$n))
#conduct the same analysis, but already using all the ports available in the traffic
OtherProt_table <- select (data, Protocol, Source, Destination)
OtherProt_table <- data.table::data.table(count(group_by(OtherProt_table, Protocol, Source, Destination)))
OtherProt_table<-dplyr::arrange(OtherProt_table, desc (OtherProt_table$n))
#save the results
write.csv(tcp_table, file = "tcp_table.csv")
write.csv(OtherProt_table, file = "OtherProt_table.csv")
