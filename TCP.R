#объ€вл€ю библиотеки
library(tidyr)
library(dplyr)
library(data.table)
#выбираю интересующий мен€ csv файл
data <- read.table(file = file.choose(), header = TRUE, sep = ",")
#создаю выборку исключительно по протоколу TCP
tcp_table <- subset(data, Protocol == "TCP", select = c(Protocol, Source, Destination))
#вы€вл€ю пару адресов, использующих протокол TCP наибольшее количество раз
tcp_table <- data.table::data.table(count(group_by(tcp_table, Protocol, Source, Destination)))
# произвожу сортировку
tcp_table<-dplyr::arrange(tcp_table, desc (tcp_table$n))
#провожу тот же анализ, но уже задейств€ все порты имеющиес€ в трафике
OtherProt_table <- select (data, Protocol, Source, Destination)
OtherProt_table <- data.table::data.table(count(group_by(OtherProt_table, Protocol, Source, Destination)))
OtherProt_table<-dplyr::arrange(OtherProt_table, desc (OtherProt_table$n))
#сохран€ю полученные результаты
write.csv(tcp_table, file = "tcp_table.csv")
write.csv(OtherProt_table, file = "OtherProt_table.csv")
