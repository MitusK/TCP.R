#�������� ����������
library(tidyr)
library(dplyr)
library(data.table)
#������� ������������ ���� csv ����
data <- read.table(file = file.choose(), header = TRUE, sep = ",")
#������ ������� ������������� �� ��������� TCP
tcp_table <- subset(data, Protocol == "TCP", select = c(Protocol, Source, Destination))
#������� ���� �������, ������������ �������� TCP ���������� ���������� ���
tcp_table <- data.table::data.table(count(group_by(tcp_table, Protocol, Source, Destination)))
# ��������� ����������
tcp_table<-dplyr::arrange(tcp_table, desc (tcp_table$n))
#������� ��� �� ������, �� ��� ��������� ��� ����� ��������� � �������
OtherProt_table <- select (data, Protocol, Source, Destination)
OtherProt_table <- data.table::data.table(count(group_by(OtherProt_table, Protocol, Source, Destination)))
OtherProt_table<-dplyr::arrange(OtherProt_table, desc (OtherProt_table$n))
#�������� ���������� ����������
write.csv(tcp_table, file = "tcp_table.csv")
write.csv(OtherProt_table, file = "OtherProt_table.csv")