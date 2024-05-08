# 본 R문서는 배건준, 서강인문논총 69, 2024 논문에서 이미 다룬 내용을 포함해,
# 1940년대 중국 제3세력 언론 데이터셋에 대한 초보적인 데이터 분석
# (또는 그것을 위한 전처리) 코드를 담고 있으며, 새로운 분석 코드를 작성할 때마다
# 업데이트 예정입니다.


# 2mode edges 데이터에서 불필요한 열을 삭제 ####
  # ex) Label, author, year

#install.packages("dplyr")
library(dplyr)
nj_edges <- nj_edges %>% 
  select(-Label, -author, -year)

write.csv(nj_edges,"3rd_table_edges/final/nj_edges.csv")
write.xlsx(jj_aj_3rd_edges,"3rd_table_edges/final/nj_edges.xlsx", rownames = FALSE)

---------------------------------------------------------
# 1mode edges 데이터에서 불필요한 열을 삭제####
  # ex) year, place

#install.packages("dplyr")
library(dplyr)
jj_aj_3rd_edges <- jj_aj_3rd_edges %>% 
  select(-year, -place)

write.csv(jj_aj_3rd_edges,"3rd_table_edges/final/jj_aj_3rd_edges.csv")
write.xlsx(jj_aj_3rd_edges,"3rd_table_edges/final/jj_aj_edges.xlsx", rownames = FALSE)

---------------------------------------------------------
# 잡지별로 어휘를 weight 내림차순으로 정렬한 데이터프레임 생성 ####

#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("openxlsx")
library(dplyr)
library(tidyr)
library(openxlsx)

df <- nj_3rd_edges

sorted_sources <- df %>%
  group_by(Target) %>%
  arrange(desc(Weight)) %>%
  mutate(rank = row_number()) %>%
  filter(rank <= 30) %>%
  ungroup()

sorted_sources_selected <- sorted_sources %>% select(Target, Source, rank)

pivot_df <- sorted_sources_selected %>%
  pivot_wider(names_from = Target, values_from = Source)

nj_3rd_nrank <- pivot_df
write.csv(pivot_df, "3rd_table_edges/analysis/nj_3rd_nrank.csv")
write.xlsx(pivot_df, file = "3rd_table_edges/analysis/nj_3rd_nrank.xlsx")

---------------------------------------------------------
# 저널 간의 관계를 행렬로 만들기 ####

#install.packages("reshape2")
#install.packages("openxlsx")
library(reshape2)
library(openxlsx)

df1 <- jj_nj_edges
df2 <- df1
df2$Target <- df1$Source
df2$Source <- df1$Target
df_combind <- rbind(df1,df2)

df_matrix <- dcast(df_combind, Source ~ Target, value.var = "Weight", fun.aggregate = sum)
write.csv(df_matrix, '3rd_table_edges/analysis/jj_nj_3rd_matrix.csv', row.names = FALSE)
write.xlsx(df_matrix, '3rd_table_edges/analysis/jj_nj_3rd_matrix.xlsx', rownames = FALSE)
jj_nj_3rd_matrix <- df_matrix


# selected_nodes <- jj_nj_nodes %>% 
#   select(Id, indegree)
# 
# # df_combind에 Weightdivin 열 추가
# df_combind <- df_combind %>%
#   left_join(selected_nodes, by = c("Source" = "Id")) %>%
#   mutate(Weightdivin = Weight / indegree)
# 
# df_matrix <- dcast(df_combind, Source ~ Target, value.var = "Weightdivin", fun.aggregate = sum)
# write.csv(df_matrix, '3rd_table_edges/analysis/jj_nj_matrix2.csv', row.names = FALSE)
# write.xlsx(df_matrix, '3rd_table_edges/analysis/jj_nj_matrix2.xlsx', rownames = FALSE)
# jj_nj_matrix2 <- df_matrix


---------------------------------------------------------
# 단일 이웃 노드 비율 계산 ####
library(dplyr)
aj_neighborcount <- aj_edges_outdegree1down_ %>%
  group_by(Target) %>%
  summarise("1down" = n_distinct(Source)) %>%
  # 두 번째 데이터프레임과 결합
  left_join(aj_outdegree2up_edges %>%
              group_by(Target) %>%
              summarise("2up" = n_distinct(Source)),
            by = "Target")
aj_neighborcount$"sum" <- (aj_neighborcount$"1down" + aj_neighborcount$"2up")
aj_neighborcount$"1dper" <- (aj_neighborcount$"1down" / (aj_neighborcount$"1down" + aj_neighborcount$"2up") * 100)
aj_neighborcount$"2uper" <- (aj_neighborcount$"2up" / (aj_neighborcount$"1down" + aj_neighborcount$"2up") * 100)

# Target과 Label을 오름차순으로 정렬
aj_neighborcount <- arrange(aj_neighborcount, desc(sum))

# View(aj_neighborcount)
write.csv(aj_neighborcount, '3rd_table_edges/analysis/aj_neighborcount.csv', row.names = FALSE)
write.xlsx(aj_neighborcount, '3rd_table_edges/analysis/aj_neighborcount.xlsx', rownames = FALSE)


---------------------------------------------------------
# 근접 중심성 왜곡 수정(실효성 재확인 필요) ####
# type2 열의 값이 "journal"인 행 추출
journals <- df %>%
  filter(type2 == "journal")

# closnesscentrality 값 추출
closeness_values <- journals$closnesscentrality

# aj_neighborcount 행렬에 closeness_values 추가
aj_neighborcount <- cbind(aj_neighborcount, closeness_values)
aj_neighborcount$cdiv1down <- (aj_neighborcount$closeness_values / aj_neighborcount$"1down")


---------------------------------------------------------
# 주요 저자 잡지별 기고 횟수 목록 만들기 ####
library(dplyr)

# 작업할 Source 값 목록
source_list <- c('郭沫若', '努生', '陶行知', '邓初民', '罗隆基', '梁纯夫', '刘大中', '陆诒', '马叙伦', '潘光旦', '潘大逵', '费孝通', '昭抡', '严信民', '吴景超', '吴世昌', '吴晗', '王亚南', '张君劢', '张东荪', '章伯钧', '储安平', '郑振铎', '周建人', '曾昭抡', '千家驹', '沈志远', '许广平', '黄药眠', '黄炎培', '景宋')

majorauthor_df1 <- data.frame(Source = character(), source = character(), stringsAsFactors = FALSE)

# 각 Source 값에 대해 작업 반복
for (source in source_list) {
  # Source 값이 현재 source에 해당하는 행 필터링
  filtered_rows <- aj_edges %>%
    filter(Source == source)
  
  # Target과 Weight 값을 조합하여 문자열로 생성
  combined_data <- paste(filtered_rows$Target, ":", filtered_rows$Weight, sep = " ")
  majorauthor_df1 <- rbind(majorauthor_df1, data.frame(Source = source, combined_data))
}
print(majorauthor_df1)
View(majorauthor_df1)
write.xlsx(majorauthor_df1, '3rd_tables/analysis/majorauthor_df1.xlsx', rownames = FALSE)

---------------------------------------------------------
# 주요 저자의 기고 잡지 추출 ####
library(reshape2)

selected_sources <- c('郭沫若', '努生', '陶行知', '邓初民', '罗隆基', '梁纯夫', '刘大中', '陆诒', '马叙伦', '潘光旦', '潘大逵', '费孝通', '昭抡', '严信民', '吴景超', '吴世昌', '吴晗', '王亚南', '张君劢', '张东荪', '章伯钧', '储安平', '郑振铎', '周建人', '曾昭抡', '曾抡昭', '千家驹', '沈志远', '许广平', '许癀平', '黄药眠', '黄炎培', '景宋')

# 선택된 Source 값들에 대한 데이터 필터링
filtered_df <- aj_edges %>%
  filter(Source %in% selected_sources)

# 데이터를 Source를 행으로, Target을 열로 변환하여 Weight 값을 매핑
majorauthor_matrix <- dcast(filtered_df, Source ~ Target, value.var = "Weight", fun.aggregate = sum)

# 결측값을 0으로 채우기
majorauthor_matrix[is.na(majorauthor_matrix)] <- 0

# 결과 출력
View(majorauthor_matrix)
write.xlsx(majorauthor_matrix, '3rd_tables/analysis/majorauthor_matrix.xlsx', rownames = FALSE)

df <- dfas
write.xlsx(df, '3rd_tables/analysis/dfas.xlsx', rownames = FALSE)
dfas <- df

---------------------------------------------------------
# 주요 저자의 핵심 어휘 추출 ####
library(reshape2)

selected_sources <- c('郭沫若', '努生', '陶行知', '邓初民', '罗隆基', '梁纯夫', '刘大中', '陆诒', '马叙伦', '潘光旦', '潘大逵', '费孝通', '昭抡', '严信民', '吴景超', '吴世昌', '吴晗', '王亚南', '张君劢', '张东荪', '章伯钧', '储安平', '郑振铎', '周建人', '曾昭抡', '曾抡昭', '千家驹', '沈志远', '许广平', '许癀平', '黄药眠', '黄炎培', '景宋')

# 선택된 Source 값들에 대한 데이터 필터링
filtered_df <- an_edges %>%
  filter(Source %in% selected_sources, Weight > 1)

# 데이터를 Source를 행으로, Target을 열로 변환하여 Weight 값을 매핑
majorauthor_matrix <- dcast(filtered_df, Source ~ Target, value.var = "Weight", fun.aggregate = sum_weights_above_2)

# 결측값을 0으로 채우기
majorauthor_matrix[is.na(majorauthor_matrix)] <- 0

# 결과 출력
View(majorauthor_matrix)
write.xlsx(majorauthor_matrix, '3rd_tables/analysis/majorauthor_n_matrix.xlsx', rownames = FALSE)


---------------------------------------------------------
# 다양한 그래프 제작 ####

df <- dfas
write.xlsx(df, '3rd_tables/analysis/dfas.xlsx', rownames = FALSE)
dfas <- df
# 7. 각 개념의 Degree와 Weighted Degree를 각각 x축과 y축으로 하는 그래프 만들기(국공 모두 포함)
#install.packages("ggplot2")
library(ggplot2)

# "type"이 "notion"인 개체들의 "Weighted Degree"와 "Degree" 열 선택
jj_aj_wd <- jj_aj_3rd_nodes[c("Id","weighted indegree","Weighted Degree")]
colnames(jj_aj_wd) <- c("Id", "aj_wd","jj_wd")


# 점 그래프 그리기
ggplot(jj_aj_wd, aes(x = aj_wd, y = jj_wd)) +
  geom_text(aes(label = Id), hjust = 0.5, vjust = -0.5, size = 3) +
  geom_point() +
  geom_smooth(method = "lm",  # 선형 회귀 분석
              se = TRUE,
              color = "blue") +
  labs(title = "Scatter Plot of aj-jj(weight)",
       x = "aj_wd",
       y = "jj_wd")

---------------------------------------------------------
library(ggplot2)

# "type"이 "notion"인 개체들의 "Weighted Degree"와 "Degree" 열 선택
author_aj_3rd_wd <- aj_3rd_nodes[aj_3rd_nodes$type == "author", c("Id","Weighted Degree")]
colnames(author_aj_3rd_wd) <- c("Id", "aj_3rd_wd")
aa_3rd_wd <- aa_aj_3rd_nodes$`Weighted Degree`

aa_aj_3rd_wd <- cbind(author_aj_3rd_wd,aa_3rd_wd)
colnames(aa_aj_3rd_wd) <- c("Id", "aj", "aa")

# 점 그래프 그리기
ggplot(aa_aj_3rd_wd, aes(x = aj, y = aa)) +
  #geom_text(aes(label = Id), hjust = 0.5, vjust = -0.5, size = 3) +
  geom_point() +
  geom_smooth(method = "lm",  # 선형 회귀 분석
              se = TRUE,
              color = "blue") +
  xlim(0,110) + 
  ylim(0,130000) +
  labs(title = "Scatter Plot of aj-jj(weight)",
       x = "aj",
       y = "aa")

