# 1. python과 sublime text로 만든 csv데이터로 Raw data 만들기 ####
install.packages("tmcn")
install.packages("dplyr")
library(tmcn)
library(dplyr)

  # 1-1. serial 열 제거, 중복 항목 제거 ####
## Python과 Sublime text로 정리한 csv 파일을 R에서 Import Dataset 기능으로 모두 실행한 후
## 1-1과 1-2를 각 데이터에 반복 시행
## 데이터 목록
## gc_csv_ gmb_csv_ gx_csv_ mzbp_csv_ mzcq_csv_ 
## mzgl_csv_ mzkm_csv_ mzsh_csv_ syw_csv_ xdwz_csv_ 
## xl_csv_ zb_csv_ zhlt_csv_ zj_csv_ zjhb_csv_ 
## zjzh_csv_ zjbp_csv_ zs_csv_ zw_csv_ zl_csv_ 
## wc_csv_ jf_csv_ qz_csv_ sdzz_csv_ zbcom_csv_ zyzk_csv_ 

df <- gc_csv_
df <- df[, -1]

  # 1-2. 발행지역 추가 ####
    # 1-2-1. 발행지가 모두 동일한 경우 ####
df$place <- "上海"

    # 1-2-2. 발행지가 해마다 다른 경우 ####
# DB에서 불러올 때 글쓴이 정보가 누락되어 정보가 한 칸씩 밀리고 page 값이 비는 행이 발생
# 발행년도를 기준으로 발행지를 부여할 때, 정보가 밀려 year열에 권호정보가 들어간 경우 발행지가 잘못 입력될 수 있음

# 결측값(NA)이 있는 행만 선택해 데이터 프레임 생성
df_missing <- df[!complete.cases(df), ]
View(df_missing)

# 밀린 열의 이름을 변경
colnames(df_missing)[colnames(df_missing) == "page"] <- "none"
colnames(df_missing)[colnames(df_missing) == "vol"] <- "page"
colnames(df_missing)[colnames(df_missing) == "year"] <- "vol"
colnames(df_missing)[colnames(df_missing) == "journal"] <- "year"
colnames(df_missing)[colnames(df_missing) == "author"] <- "journal"
colnames(df_missing)[colnames(df_missing) == "none"] <- "author"

# df에서 결측값(NA) 포함하는 행을 제거한 별도의 데이터를 만들고, author가 비어있는 데이터와 결합
df2 <- df[complete.cases(df), ] # df2: 저자 정보가 있는 기사만 포함하는 데이터프레임
df <- rbind(df2,df_missing)    # df에 각 정보가 밀린 행을 모두 조정한 데이터프레임

# year 값이 얼마일 때 어떤 place값을 부여할지 입력하고, 맨 마지막에는 그 외 나머지에 부여할 값을 입력
df$place <- ifelse(df$year == "1945", "重庆", "南京")

# 더 많은 연도에 대해 다른 값을 부여해야 할 경우
# df$place <- ifelse(df$year == "1945", "重庆",
#                   ifelse(df$year == "1944", "重庆",
#                          ifelse(df$year == "1943", "重庆",
#                                ifelse(df$year == "1942", "重庆", "南京"))))


    # 1-2-3. 파일로 저장, 잡지별 데이터셋으로 저장 ####
write.csv(df, 'csv_journal/gc(csv)p.csv', row.names = FALSE)
gc_csv_p <- df

  # 1-3. 전체를 합한 데이터프레임 만들기 ####
dfc <- rbind(gc_csv_p, gmb_csv_p, gx_csv_p, mzbp_csv_p, mzcq_csv_p, 
             mzgl_csv_p, mzkm_csv_p, mzsh_csv_p, syw_csv_p, xdwz_csv_p, 
             xl_csv_p, zb_csv_p, zhlt_csv_p, zj_csv_p, zjhb_csv_p, 
             zjzh_csv_p, zjbp_csv_p, zs_csv_p, zw_csv_p, zl_csv_p, 
             wc_csv_p, jf_csv_p, qz_csv_p, sdzz_csv_p, zbcom_csv_p, zyzk_csv_p)

dfc <- dfc %>% distinct_all() # 중복 항목 제거
dfc <- dfc[!is.na(dfc$title), ] # 제목 없는 항목 제거
write.csv(dfc, 'csv_base/dfc.csv', row.names = FALSE)

  # 1-4. 글쓴이 누락 기사 재정렬 ####
# DB에서 불러올 때 글쓴이 정보가 누락되어 정보가 한 칸씩 밀리고 page 값이 비는 행이 발생
# page열에 결측값(NA)이 있는 행만 선택해 데이터 프레임 생성
dfc_missing <- dfc[is.na(dfc$page), ]
#View(dfc_missing)

# 밀린 열의 이름을 변경
colnames(dfc_missing)[colnames(dfc_missing) == "page"] <- "none"
colnames(dfc_missing)[colnames(dfc_missing) == "vol"] <- "page"
colnames(dfc_missing)[colnames(dfc_missing) == "year"] <- "vol"
colnames(dfc_missing)[colnames(dfc_missing) == "journal"] <- "year"
colnames(dfc_missing)[colnames(dfc_missing) == "author"] <- "journal"
colnames(dfc_missing)[colnames(dfc_missing) == "none"] <- "author"

# dfc에서 결측값(NA) 포함하는 행을 제거한 별도의 데이터를 만들고, author가 비어있는 데이터와 결합
dfp <- dfc[!is.na(dfc$page),] # dfp: author정보 누락으로 발생한 page열의 결측값이 없는 기사만 포함하는 데이터프레임
dfc2 <- rbind(dfp,dfc_missing)    # dfc2: 저자 정보가 없는 기사까지 포함하는 데이터프레임
dfa <- dfc2[!is.na(dfc2$author),] # dfa: 저자 정보가 있는 기사만 포함하는 데이터프레임

  # 1-5. 잡지명에 《》추가, year열을 숫자형으로 변환 ####
# 개념 분석시 잡지명과 같은 단어가 걸리지 않도록 잡지명에 괄호 추가
dfc2$journal <- paste("《", dfc2$journal, "》", sep = "")
dfa$journal <- paste("《", dfa$journal, "》", sep = "")

# 연도별 정렬 및 sorting에 용이하도록 year열의 형식을 character에서 integer(정수)으로 변환
dfc2$year <- as.integer(dfc2$year)
dfa$year <- as.integer(dfa$year)

  # 1-6. 실제 분석에 사용할 간체 데이터 열 추가 ####
# 이하 과정에서 컴퓨터는 간체와 번체를 서로 다른 글자로 인식, 한 쪽으로 통일해야 함
# 데이터를 불러온 DB가 기본적으로 간체자를 채택하는 것을 고려해 간체로 통일
# 다만 원문 확인이 필요한 경우가 있으므로 원 데이터를 보존
# install.packages("tmcn")
# library(tmcn)

# rawdata용 열을 따로 만들어 보존
dfc2$title_raw <- dfc2$title
dfc2$author_raw <- dfc2$author
dfa$title_raw <- dfa$title
dfa$author_raw <- dfa$author 

# 간체 변환한 데이터로 기존 열 대체
dfc2$author <- toTrad(dfc2$author, rev = TRUE)
dfc2$title <- toTrad(dfc2$title, rev = TRUE)
dfa$author <- toTrad(dfa$author, rev = TRUE)
dfa$title <- toTrad(dfa$title, rev = TRUE)

  # 1-7. 기본 데이터 파일 저장 ####
write.csv(dfa, 'csv_base/dfa.csv', row.names = FALSE)
write.csv(dfc2, 'csv_base/dfc2.csv', row.names = FALSE)

################################################################################

# 2. 저자 데이터 전처리 ####
  # 이름 오기나 간체-번체 차이로 같은 사람이 따로 카운팅되는 것을 막기 위한 전처리 작업
# install.packages("tidyr")
# install.packages("dplyr")
library(tidyr)
library(dplyr)

  # 2-1. author별 빈도 1차 카운팅, 전처리 작업을 위한 참고용 ####
author_counts <- table(dfa$author)
author_counts_df <- as.data.frame(author_counts, colnames = c("author", "frequency"))
author_counts_df <- author_counts_df[order(author_counts_df$Freq, decreasing = TRUE), ]

  # 2-2. 데이터 프레임 내의 특정 문자열을 다른 문자열로 대체(찾아 바꾸기)####
    # 2-2-1. 기호 처리 ####
    # author에 포함된 물음표("?") 제거 
    # 이름이 물음표로만 되어 있는 기사 제거
## gsub 함수에서 "?" 문자열이 기능을 가지고 있기 때문에, 그 기능을 작동시키지 않고 물음표를 찾으려면 "\\"를 이용(이스케이프)
dfa <- dfa[dfa$author != "?", ]
dfa$author <- gsub("\\?", "", dfa$author)

# author에 들어있는 반각 괄호를 전각 괄호로 통일
dfa$author <- gsub("\\(", "（", dfa$author)
dfa$author <- gsub("\\)", "）", dfa$author)

    # 2-2-2. 영문명의 띄어쓰기를 언더바(_)로 변환 ####
dfa$author <- gsub("William Winter", "William_Winter", dfa$author)
dfa$author <- gsub("William W. Lockwood", "William_W._Lockwood", dfa$author)
dfa$author <- gsub("William Blake", "William_Blake", dfa$author)
dfa$author <- gsub("W. B. Yeats", "W._B._Yeats", dfa$author)
dfa$author <- gsub("Victor Perlo", "Victor_Perlo", dfa$author)
dfa$author <- gsub("Thomas Carlyle", "Thomas_Carlyle", dfa$author)
dfa$author <- gsub("Nathaniel Peffer", "Nathaniel_Peffer", dfa$author)
dfa$author <- gsub("Michael Straight", "Michael_Straight", dfa$author)
dfa$author <- gsub("Maxwell S. Stewart", "Maxwell_S._Stewart", dfa$author)
dfa$author <- gsub("Mark Gayn", "Mark_Gayn", dfa$author)
dfa$author <- gsub("Leo Rissin", "Leo_Rissin", dfa$author)
dfa$author <- gsub("Kingsley Martir", "Kingsley_Martin", dfa$author)
dfa$author <- gsub("Kingsley Martin", "Kingsley_Martin", dfa$author)
dfa$author <- gsub("John K. Fairbank", "John_K._Fairbank", dfa$author)
dfa$author <- gsub("Howard K. Smith", "Howard_K._Smith", dfa$author)
dfa$author <- gsub("Henry J. Taylor", "Henry_J._Taylor", dfa$author)
dfa$author <- gsub("Gordon W. Allport", "Gordon_W._Allport", dfa$author)
dfa$author <- gsub("Gilberts Freyre", "Gilberts_Freyre", dfa$author)
dfa$author <- gsub("Georges Gurvitch", "Georges_Gurvitch", dfa$author)
dfa$author <- gsub("Fritz Sternberg", "Fritz_Sternberg", dfa$author)
dfa$author <- gsub("F. Geyrasi", "F._Geyrasi", dfa$author)
dfa$author <- gsub("Donald Morrow", "Donald_Morrow", dfa$author)
dfa$author <- gsub("David Ramsey", "David_Ramsey", dfa$author)
dfa$author <- gsub("Arnold Toynbee", "Arnold_Toynbee", dfa$author)
dfa$author <- gsub("Aldous Huxley", "Aldous_Huxley", dfa$author)
dfa$author <- gsub("Adelaide Keu", "Adelaide_Keu", dfa$author)
dfa$author <- gsub("Alden Hatch", "Alden_Hatch", dfa$author)
dfa$author <- gsub("Alexander Kendrick", "Alexander_Kendrick", dfa$author)
dfa$author <- gsub("ALLEU W. Dulles", "ALLEU_W._Dulles", dfa$author)
dfa$author <- gsub("Andrc Visson", "Andrc_Visson", dfa$author)
dfa$author <- gsub("Arnodl Burnett", "Arnold_Burnett", dfa$author)
dfa$author <- gsub("B Shiuo Rao", "B_Shiuo_Rao", dfa$author)
dfa$author <- gsub("B. Ifor Evans", "B._Ifor_Evans", dfa$author)
dfa$author <- gsub("Barnet Nover", "Barnet_Nover", dfa$author)
dfa$author <- gsub("Dan L Thlapp", "Dan_L_Thlapp", dfa$author)
dfa$author <- gsub("Emery Reves", "Emery_Reves", dfa$author)
dfa$author <- gsub("Francis Sill wickwrne", "Francis_Sill_wickwrne", dfa$author)
dfa$author <- gsub("FREDA UTLEY", "FREDA_UTLEY", dfa$author)
dfa$author <- gsub("Frederick Lewis Alleu", "Frederick_Lewis_Alleu", dfa$author)
dfa$author <- gsub("Granville Hicks", "Granville_Hicks", dfa$author)
dfa$author <- gsub("H.E.Fosdick", "H.E.Fosdick", dfa$author)
dfa$author <- gsub("Hans Benclix", "Hans_Benclix", dfa$author)
dfa$author <- gsub("Harold Sugg", "Harold_Sugg", dfa$author)
dfa$author <- gsub("Harsy Shwartz", "Harsy_Shwartz", dfa$author)
dfa$author <- gsub("J. F. Dulles", "T._F._Dulles", dfa$author)
dfa$author <- gsub("J. H. Spigelman", "J._H._Spigelman", dfa$author)
dfa$author <- gsub("John N. Washburn", "John_N._Washburn", dfa$author)
dfa$author <- gsub("K. Zilliacus", "K._Zilliacus", dfa$author)
dfa$author <- gsub("Kenneth de Coorcy", "Kenneth_de_Coorcy", dfa$author)
dfa$author <- gsub("Kingsley Martin", "Kingsley_Martin", dfa$author)
dfa$author <- gsub("Lohn Strohm", "Lohn_Strohm", dfa$author)
dfa$author <- gsub("Lorna B G. robb", "Lorna_B_G._robb", dfa$author)
dfa$author <- gsub("Louis Bromfield", "Louis_Bromfield", dfa$author)
dfa$author <- gsub("Louis Brbmficld", "Louis_Bromfield", dfa$author)
dfa$author <- gsub("Malcolm Burr", "Malcolm_Burr", dfa$author)
dfa$author <- gsub("Manuel Z. Olbes", "Manuel_Z._Olbes", dfa$author)
dfa$author <- gsub("Mark Sulliivau", "Mark_Sulliivau", dfa$author)
dfa$author <- gsub("Mary Knight", "Mary_Knight", dfa$author)
dfa$author <- gsub("Maurice Hinbu", "Maurice_Hinbu", dfa$author)
dfa$author <- gsub("Mewhinnie", "Mewhinnie", dfa$author)
dfa$author <- gsub("Nina I. Alexeier", "Nina_I._Alexeier", dfa$author)
dfa$author <- gsub("Orlana Atklnson", "Orlana_Atklnson", dfa$author)
dfa$author <- gsub("Phillis Bentley", "Phillis_Bentley", dfa$author)
dfa$author <- gsub("Pupert Emerson", "Pupert_Emerson", dfa$author)
dfa$author <- gsub("Richard D. Moalar", "Richard_D._Moalar", dfa$author)
dfa$author <- gsub("Richard E. Lauterbach", "Richard_E._Lauterbach", dfa$author)
dfa$author <- gsub("Rodneg Gilbert", "Rodneg_Gilbert", dfa$author)
dfa$author <- gsub("Ronald Darison", "Ronald_Darison", dfa$author)
dfa$author <- gsub("Rufus Jarman", "Rufus_Jarman", dfa$author)
dfa$author <- gsub("S. Raja Ratnam", "S._Raja_Ratnam", dfa$author)
dfa$author <- gsub("Stantey Barnes", "Stantey_Barnes", dfa$author)
dfa$author <- gsub("Saw Tun", "Saw_Tun", dfa$author)
dfa$author <- gsub("Sidney Hook", "Sidney_Hook", dfa$author)
dfa$author <- gsub("T. F. Dulles", "T._F._Dulles", dfa$author)
dfa$author <- gsub("T.F.Dulles", "T._F._Dulles", dfa$author)
dfa$author <- gsub("Thomas F. Haniltor", "Thomas_F._Haniltor", dfa$author)
dfa$author <- gsub("V. B. Wigglesworth", "V._B._Wigglesworth", dfa$author)
dfa$author <- gsub("Victor Krauehenko", "Victor_Krauehenko", dfa$author)
dfa$author <- gsub("W. H. Ewer", "W._H._Ewer", dfa$author)
dfa$author <- gsub("W.H. Chamberliu", "W.H._Chamberliu", dfa$author)
dfa$author <- gsub("Wickham Steed", "Wickham_Steed", dfa$author)
dfa$author <- gsub("Arthur Cleeg", "Arthur_Cleeg", dfa$author)
dfa$author <- gsub("David Arnold", "David_Arnold", dfa$author)
dfa$author <- gsub("A. STROGANOV", "A._STROGANOV", dfa$author)
dfa$author <- gsub("Kenneth Wood", "Kenneth_Wood", dfa$author)
dfa$author <- gsub("Losio Kodzada", "Losio_Kodzada", dfa$author)
dfa$author <- gsub("M. K.", "M._K.", dfa$author)
dfa$author <- gsub("S. D", "S._D", dfa$author)
dfa$author <- gsub("Worso Chua", "Worso_Chua", dfa$author)
dfa$author <- gsub("Anna L.Strong", "Anna_L.Strong", dfa$author)
# 계속 추가 필요

  # 2-3. 공저자 분리 ####
# install.packages("tidyr")
# library(tidyr)
dfas <- separate_rows(dfa, author, sep = " ") # 공저자를 분리해 모든 공저자가 기사와 1대 1로 매칭되는 df
write.csv(dfas, 'csv_base/dfas.csv', row.names = FALSE)

  # 2-4. 1차 데이터 생성 이후 데이터 정리 ####
    # 2-4-1. 동일인물이 다르게 표기된 경우를 찾아 문자열 일치시키기(계속 추가) ####
dfas$author <- gsub("（缅）Saw_Tun", "（缅甸）Saw_Tun", dfas$author)
dfas$author <- gsub("John_K._Fairbank", "费正清", dfas$author)
dfas$author <- gsub("（美）费正清", "费正清", dfas$author)
dfas$author <- gsub("LASKI.H.J", "拉斯基", dfas$author)
dfas$author <- gsub("Laski，H.J.", "拉斯基", dfas$author)
dfas$author <- gsub("Laski", "拉斯基", dfas$author)
dfas$author <- gsub("（英）拉斯基教授", "拉斯基", dfas$author)
dfas$author <- gsub("（英）拉斯基", "拉斯基", dfas$author)
dfas$author <- gsub("（美）华莱士", "华莱士", dfas$author)
dfas$author <- gsub("Wallace，H.A.", "华莱士", dfas$author)
dfas$author <- gsub("（苏）特拉伊宁", "特拉伊宁", dfas$author)
dfas$author <- gsub("（美）丹尼斯", "（美）E·丹尼斯", dfas$author)
dfas$author <- gsub("（美）赛珍珠", "赛珍珠", dfas$author)
dfas$author <- gsub("Anna_L.Strong", "史特朗", dfas$author)
dfas$author <- gsub("（美）史特朗", "史特朗", dfas$author)
dfas$author <- gsub("安娜·史特朗", "史特朗", dfas$author)
dfas$author <- gsub("安娜·史特郎", "史特朗", dfas$author)
dfas$author <- gsub("黄__眠", "黄药眠", dfas$author)
dfas$author <- gsub("黄药眠", "药眠", dfas$author)
dfas$author <- gsub("药眠", "黄药眠", dfas$author)
dfas$author <- gsub("金大__", "金大均", dfas$author)
dfas$author <- gsub("黄炎培", "炎培", dfas$author)
dfas$author <- gsub("炎培", "黄炎培", dfas$author)
dfas$author <- gsub("张文伯", "文伯", dfas$author)
dfas$author <- gsub("文伯", "张文伯", dfas$author)
dfas$author <- gsub("曾昭抡", "昭抡", dfas$author)
dfas$author <- gsub("昭抡", "曾昭抡", dfas$author)
dfas$author <- gsub("曾抡昭", "曾昭抡", dfas$author)
dfas$author <- gsub("努生", "罗隆基", dfas$author)
dfas$author <- gsub("MH", "M.H.", dfas$author)
dfas$author <- gsub("许癀平", "许广平", dfas$author)
dfas$author <- gsub("景宋", "许广平", dfas$author)

# 계속 추가 필요

    # 2-4-2. 다른 저자가 동일 저자인 것처럼 혼동을 일으키거나, 필진을 특정하기 어려운 저자 제외하기 ####
# author 값으로 불려온 텍스트 중 "蒋"은 《中央周刊》에 40회, 《群众》에 17회 등장
  # 《中央周刊》쪽은 사론, 《群众》쪽은 문건류에 이 저자명이 붙어 있음.
  # 서로 반대쪽 지형에 위치한 두 잡지의 유일한 연결고리이지만,
  # 필진을 특정할 수 없고, 같은 필자를 가리킬 가능성은 거의 없음.
  # "蒋"이 사람 이름에 들어있는 경우를 제외하고 나머지는 모두 삭제
dfas$author <- gsub(" 蒋", "", dfas$author)
dfas <- dfas[dfas$author != "蒋", ]

# author 값으로 불려온 텍스트 중 "芝", "印" 등은 편집진을 나타내는 것으로 보이나, 원문에는 표기되어있지 않음.
  # 사람 이름에 들어있는 경우("芝峰")를 제외하고 나머지는 모두 삭제
dfas$author <- gsub(" 芝", "", dfas$author)
dfas <- dfas[dfas$author != "芝", ]
dfas$author <- gsub(" 印", "", dfas$author)
dfas <- dfas[dfas$author != "印", ]

    # 2-4-3. 한 글자 author 일괄 제거 ####
# 향후 전체 데이터에 대해 이상과 같은 세밀한 데이터 정리가 필요하지만,
# 데이터가 완전히 정리되기 전에는 공저자 분리 이후(2-3.) author 값 중 한 글자로 된 것을 일괄 제외하는 방법으로 어느 정도 정리 가능
# 한 글자로 된 author의 경우 식별 가능하다 하더라도 다른 저자와 동일 저자로 잡혀 혼동을 일으킬 수 있음
# 다만 향후 더 정확한 분석을 위해 한 글자 author가 각각 누구를 가리키는지 확인하는 작업 필요
# install.packages("dplyr")
# library(dplyr)

dfas_trimed_ <- dfas %>%
  filter(nchar(author) > 1)
write.csv(dfas_trimed_, 'csv_base/dfas(trimed).csv', row.names = FALSE)

  # 2-5. author별 빈도 2차 카운팅 ####
author_counts2 <- table(dfas$author)
author_counts_df2 <- as.data.frame(author_counts2, colnames = c("author", "frequency"))
author_counts_df2 <- author_counts_df2[order(author_counts_df2$Freq, decreasing = TRUE), ]

################################################################################
# 3. 저자-잡지 데이터 만들기 ####
#install.packages("dplyr")
library(dplyr)

    # 3-1-1. target, year, place별로 source의 빈도를 계산 ####
aj_selected <- dfas %>% select(author,journal,year,place)

aj <- aj_selected %>%
  group_by(author,journal,year,place) %>%
  summarise(weight = n()) %>%   # 빈도가 gephi에 탑재할 때 가중치로 입력되도록 weight로 명명
  arrange(year, desc(weight))

aj$weight <- as.integer(aj$weight)

# 결과 출력
colnames(aj)[colnames(aj) == "author"] <- "source"
colnames(aj)[colnames(aj) == "journal"] <- "target"
#View(aj)
write.csv(aj, 'csv_for_gephi/aj.csv', row.names = FALSE)

    # 3-1-2. 국민당 공산당 저널 제외한 데이터프레임 만들기 ####
aj_3rd <- aj %>%
  filter(target != "《中央周刊》",
         target != "《解放》",
         target != "《时代杂志》",
         target != "《正报》",
         target != "《群众》",
         target != "《文萃》")
write.csv(aj_3rd, file = 'csv_for_gephi/aj_3rd.csv', row.names = FALSE)

  # 3-2. 시계열(time serial) 분석을 위한 데이터 ####

    # 3-2-1. source(및 target) 값에 year 추가 ####
## 원 csv 파일을 gephi에 탑재하면서 year 값을 무시하고 한 개체로 합쳐지고,
## 이 때 가장 큰 year 값만 남게 됨
## 연도별 시계열 분석을 진행할 때 값의 왜곡이 발생하므로, 
## 이를 해결하기 위해 source 값에 연도 정보를 추가

library(dplyr)

aj_ts <- aj %>%
  mutate(source = paste(source, "(", year, ")", sep = ""))
write.csv(aj_ts, file = 'csv_for_gephi/aj_ts.csv', row.names = FALSE)

aj_3rd_ts <- aj_3rd %>%
  mutate(source = paste(source, "(", year, ")", sep = ""))
write.csv(aj_3rd_ts, file = 'csv_for_gephi/aj_3rd_ts.csv', row.names = FALSE)

    # 3-2-2. Label 값 부여하기 ####
# source(및 target) 값에 붙인 year 값이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여

      # 3-2-2-1. aj_ts ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_aj_ts <- unique(aj_ts$source)

# lable 데이터프레임 생성
lable_value_aj_ts <- gsub("\\(1945\\)$", "", unique_s_aj_ts)
lable_value_aj_ts <- gsub("\\(1946\\)$", "", lable_value_aj_ts)
lable_value_aj_ts <- gsub("\\(1947\\)$", "", lable_value_aj_ts)
lable_value_aj_ts <- gsub("\\(1948\\)$", "", lable_value_aj_ts)
lable_value_aj_ts <- gsub("\\(1949\\)$", "", lable_value_aj_ts)

aj_ts_lable <- data.frame(Id = c(unique_s_aj_ts),
                          Label = c(lable_value_aj_ts))
write.csv(aj_ts_lable, 'csv_for_gephi/aj_ts_lable.csv', row.names = FALSE)
## aj_ts.csv를 gephi에서 실행한 후 aj_ts_lable을 import spreadsheet로 적용

      # 3-2-2-2. aj_3rd_ts ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_aj_3rd_ts <- unique(aj_3rd_ts$source)

# lable 데이터프레임 생성
lable_value_aj_3rd_ts <- gsub("\\(1945\\)$", "", unique_s_aj_3rd_ts)
lable_value_aj_3rd_ts <- gsub("\\(1946\\)$", "", lable_value_aj_3rd_ts)
lable_value_aj_3rd_ts <- gsub("\\(1947\\)$", "", lable_value_aj_3rd_ts)
lable_value_aj_3rd_ts <- gsub("\\(1948\\)$", "", lable_value_aj_3rd_ts)
lable_value_aj_3rd_ts <- gsub("\\(1949\\)$", "", lable_value_aj_3rd_ts)

aj_3rd_ts_lable <- data.frame(Id = c(unique_s_aj_3rd_ts),
                              Label = c(lable_value_aj_3rd_ts))
write.csv(aj_3rd_ts_lable, 'csv_for_gephi/aj_3rd_ts_lable.csv', row.names = FALSE)
## aj_3rd_ts.csv를 gephi에서 실행한 후 aj_3rd_ts_lable을 import spreadsheet로 적용

################################################################################
# 4. 저자-개념 네트워크 분석 ####
  # 4-1. 기사 제목 파싱 ####
    # 4-1-1. 패키지 설치, 실행 ####
#install.packages("jiebaRD")
#install.packages("jiebaR")
#install.packages("NLP")
#install.packages("tm")
#install.packages("tibble")
#install.packages("dplyr")
#install.packages("tidyr")
library(jiebaRD)
library(jiebaR)
library(NLP)
library(tm)
library(tibble)
library(dplyr)
library(tidyr)

    # 4-1-2. 불용어와 유저 딕셔너리 설정, 커터 생성 ####
sw_path <- "3rd_stopwords.txt"
ud_path <- "3rd_dict.txt"
cutter <- worker(type = "mix", dict = "jieba.dict.utf8", user = ud_path, stop_word = sw_path)

    # 4-1-3. 파서 실행 ####
# 기사 제목 뒤에 기사별 구분점(uuu) 추가
dfasp <- dfas  # dfasp: parsing한 데이터를 dfas에 결합하기 위한 새로운 df
dfasp$text <- paste(dfasp$title,"uuu")

# 구분점 추가된 기사 제목만 선택
titles <- as.character(dfasp$text)

# 세그먼트 데이터 파일로 저장
segtitle <- segment(titles, cutter)
segtitlepaste <- paste(segtitle, collapse = " ")
write(segtitlepaste,"segtitle.txt")

    # 4-1-4. sublime text를 이용해 " uuu "를 \n(정규표현식)로 찾아바꾸고, 첫 행에 열 제목 seg_text를 추가 ####
## 이때 파싱 과정에서 제목의 문자열이 모두 제거된 열의 경우 " uuu "로 검색이 되지 않으므로 추가로 "uuu " 또는 " uuu"를 찾아 \n으로 바꿔야 하고,
## 이 경우 아래 read.table로 불러올 때 인식되지 않기 때문에 문자열을 인식시키기 위해 
## "\n\n"인 부분을 찾아 "\n_\n"으로 바꿔야 함. "\n\n"이 없을 때까지 시행
## 맨 마지막 행의 "_"는 삭제한 후 저장
## 언더바(_)는 아래에서 ""으로 변환

    # 4-1-5. 분절된 제목 데이터를 기존 df에 결합 ####
seg_text <- read.table('segtitle.txt',sep = '\t',header = TRUE)

## 생성된 seg_text와 dfas의 행 갯수 확인, 두 숫자가 동일해야 결합 가능
nrow(seg_text)
nrow(dfasp)

dfasp<-cbind(dfasp, seg_text) 
dfasp$seg_text <- gsub("_", "", dfasp$seg_text) # 언더바("_")를 ""으로 변환

# View(dfasp)
write.csv(dfasp,"csv_base/dfasp.csv")

    # 4-1-6. seg_text 단어 단위로 행을 분절,  ####
dfasps <- separate_rows(dfasp, seg_text, sep = " ")
# View(dfasps)
write.csv(dfasps,"csv_base/dfasps.csv")

    # 4-1-7. 분절한 단어 중 한 글자 단어 정리
# 불용어로 설정한 단어 중 제거되지 않은 것과 
# 사용자 사전에 정의하지 못한 고유명사 등이 한 글자로 분절된 경우가 있음
# 남아있는 불용어와 정확하게 분절되지 않은 것을 삭제
dfasps_trimed_ <- dfasps %>%
  filter(nchar(seg_text) > 1)
write.csv(dfasps_trimed_,"csv_base/dfasps(trimed).csv")

  # 4-2. seg_text,year,place별로 author의 빈도를 계산 ####
an_selected <- dfasps %>% select(author,seg_text,year,place,journal)

an <- an_selected %>%
  group_by(author,seg_text,year,place,journal) %>%
  summarise(weight = n()) %>%
  arrange(year, desc(weight))

an$weight <- as.integer(an$weight)

colnames(an)[colnames(an) == "author"] <- "source"
colnames(an)[colnames(an) == "seg_text"] <- "target"

# 결과 출력, 비어있는데 비어있다고 인식되지 않는 칸을 강제로 결측값으로 변환하여 제거
an$target[an$target == ""] <- NA
an <- an[complete.cases(an), ]

# View(an)

  # 4-3. 국민당 공산당 저널 제외한 데이터프레임 만들기 ####
an_3rd <- an %>%
  filter(journal != "《中央周刊》",
         journal != "《解放》",
         journal != "《时代杂志》",
         journal != "《正报》",
         journal != "《群众》",
         journal != "《文萃》")
# View(an_3rd)

  # 4-4. 저자와 개념의 구분을 위한 전처리 ####
## 인물이 언급 대상이 되는 경우, 저자와 개념이 한 노드에서 뒤섞이게 됨 이를 방지하기 위해 target 값을 구분
    # 4-4-1. target 값 뒤에 "(n)" 추가한 후 저장 ####
an$target <- paste(an$target, "(n)")
an_3rd$target <- paste(an_3rd$target, "(n)")
write.csv(an, 'csv_for_gephi/an.csv', row.names = FALSE)
write.csv(an_3rd, file = 'csv_for_gephi/an_3rd.csv', row.names = FALSE)

    # 4-4-2. type값(author, notion) 및 Label 값 부여하기 ####
      # 4-4-2-1. an 데이터(국공 포함) ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s <- unique(an$source)
unique_t <- unique(an$target)

# 새로운 데이터프레임 생성
an_type1 <- data.frame(Id = c(unique_s),
                       Label = c(unique_s),
                       type = rep("author", length(unique_s)))

# 앞서 target 값에 붙여놨던 "(n)"이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여
lable_value <- gsub(" \\(n\\)$", "", unique_t)
an_type2 <- data.frame(Id = c(unique_t),
                       Label = c(lable_value),
                       type = rep("notion", length(unique_t)))

an_type <- rbind(an_type1,an_type2)
write.csv(an_type, 'csv_for_gephi/an_type.csv', row.names = FALSE)
## an.csv를 gephi에서 실행한 후 an_type을 import spreadsheet로 적용

      # 4-4-2-2. an_3rd 데이터(국공 불포함) ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_3rd <- unique(an_3rd$source)
unique_t_3rd <- unique(an_3rd$target)

# 새로운 데이터프레임 생성
an_3rd_type1 <- data.frame(Id = c(unique_s_3rd),
                           Label = c(unique_s_3rd),
                           type = rep("author", length(unique_s_3rd)))

# 앞서 target 값에 붙여놨던 "(n)"이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여
lable_value_3rd <- gsub(" \\(n\\)$", "", unique_t_3rd)
an_3rd_type2 <- data.frame(Id = c(unique_t_3rd),
                           Label = c(lable_value_3rd),
                           type = rep("notion", length(unique_t_3rd)))

an_3rd_type <- rbind(an_3rd_type1,an_3rd_type2)
write.csv(an_3rd_type, 'csv_for_gephi/an_3rd_type.csv', row.names = FALSE)


  # 4-5. 시계열(time serial) 분석을 위한 데이터 ####

    # 4-5-1. source 값에 year 추가 ####
## 원 csv 파일을 gephi에 탑재하면서 year 값을 무시하고 한 개체로 합쳐지고,
## 이 때 가장 큰 year 값만 남게 됨
## 연도별 시계열 분석을 진행할 때 값의 왜곡이 발생하므로, 
## 이를 해결하기 위해 source 값에 연도 정보를 추가

library(dplyr)

an_ts <- an %>%
  mutate(source = paste(source, "(", year, ")", sep = ""))
write.csv(an_ts, file = 'csv_for_gephi/an_ts.csv', row.names = FALSE)

an_3rd_ts <- an_3rd %>%
  mutate(source = paste(source, "(", year, ")", sep = ""))
write.csv(an_3rd_ts, file = 'csv_for_gephi/an_3rd_ts.csv', row.names = FALSE)

    # 4-5-2. Label 값 부여하기 ####
# source(및 target) 값에 붙인 year 값이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여

      # 4-5-2-1. an_ts ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_an_ts <- unique(an_ts$source)
unique_t_an_ts <- unique(an_ts$target)

# lable 데이터프레임 생성
s_value_an_ts <- gsub("\\(1945\\)$", "", unique_s_an_ts)
s_value_an_ts <- gsub("\\(1946\\)$", "", s_value_an_ts)
s_value_an_ts <- gsub("\\(1947\\)$", "", s_value_an_ts)
s_value_an_ts <- gsub("\\(1948\\)$", "", s_value_an_ts)
s_value_an_ts <- gsub("\\(1949\\)$", "", s_value_an_ts)

an_ts_a_lable <- data.frame(Id = c(unique_s_an_ts),
                            Label = c(s_value_an_ts),
                            type = rep("author", length(unique_s_an_ts)))

# 앞서 target 값에 붙여놨던 "(n)"이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여
t_value_an_ts <- gsub(" \\(n\\)$", "", unique_t_an_ts)

an_ts_n_lable <- data.frame(Id = c(unique_t_an_ts),
                            Label = c(t_value_an_ts),
                            type = rep("notion", length(unique_t_an_ts)))

an_ts_lable <- rbind(an_ts_a_lable, an_ts_n_lable)
write.csv(an_ts_lable, 'csv_for_gephi/an_ts_lable.csv', row.names = FALSE)
## an_ts.csv를 gephi에서 실행한 후 an_ts_lable을 import spreadsheet로 적용

      # 4-5-2-2. an_3rd_ts ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_an_3rd_ts <- unique(an_3rd_ts$source)
unique_t_an_3rd_ts <- unique(an_3rd_ts$target)

# lable 데이터프레임 생성
s_value_an_3rd_ts <- gsub("\\(1945\\)$", "", unique_s_an_3rd_ts)
s_value_an_3rd_ts <- gsub("\\(1946\\)$", "", s_value_an_3rd_ts)
s_value_an_3rd_ts <- gsub("\\(1947\\)$", "", s_value_an_3rd_ts)
s_value_an_3rd_ts <- gsub("\\(1948\\)$", "", s_value_an_3rd_ts)
s_value_an_3rd_ts <- gsub("\\(1949\\)$", "", s_value_an_3rd_ts)

an_3rd_ts_a_lable <- data.frame(Id = c(unique_s_an_3rd_ts),
                                Label = c(s_value_an_3rd_ts),
                                type = rep("author", length(unique_s_an_3rd_ts)))

# 앞서 target 값에 붙여놨던 "(n)"이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여
t_value_an_3rd_ts <- gsub(" \\(n\\)$", "", unique_t_an_3rd_ts)
an_3rd_ts_t_lable <- data.frame(Id = c(unique_t_an_3rd_ts),
                                Label = c(t_value_an_3rd_ts),
                                type = rep("notion", length(unique_t_an_3rd_ts)))

an_3rd_ts_lable <- rbind(an_3rd_ts_a_lable, an_3rd_ts_t_lable)

write.csv(an_3rd_ts_lable, 'csv_for_gephi/an_3rd_ts_lable.csv', row.names = FALSE)
## an_3rd_ts.csv를 gephi에서 실행한 후 an_3rd_ts_lable을 import spreadsheet로 적용

################################################################################
# 5. 개념-잡지 네트워크 분석 ####
  # 5-1. 기사 제목 파싱 ####
    # 5-1-1. 패키지 설치, 실행 ####
#install.packages("jiebaRD")
#install.packages("jiebaR")
#install.packages("NLP")
#install.packages("tm")
#install.packages("tibble")
#install.packages("dplyr")
#install.packages("tidyr")
library(jiebaRD)
library(jiebaR)
library(NLP)
library(tm)
library(tibble)
library(dplyr)
library(tidyr)

    # 5-1-2. 불용어와 유저 딕셔너리 설정, 커터 생성 ####
sw_path <- "3rd_stopwords.txt"
ud_path <- "3rd_dict.txt"
cutter <- worker(type = "mix", dict = "jieba.dict.utf8", user = ud_path, stop_word = sw_path)

    # 5-1-3. 파서 실행 ####
# 기사별 구분점(uuu) 추가
dfc2$text <- paste(dfc2$title,"uuu")

# 구분점 추가된 기사 제목만 선택
titles2 <- as.character(dfc2$text)

# 세그먼트 데이터 파일로 저장
segtitle2 <- segment(titles2, cutter)
segtitlepaste2 <- paste(segtitle2, collapse = " ")
write(segtitlepaste2,"segtitle2.txt")

    # 5-1-4. sublime text를 이용해 " uuu "를 \n(정규표현식)로 찾아바꾸고, 첫 행에 열 제목 seg_text를 추가 ####
## 이때 파싱 과정에서 제목의 문자열이 모두 제거된 열의 경우 " uuu "로 검색이 되지 않으므로 추가로 "uuu " 또는 " uuu"를 찾아 \n으로 바꿔야 하고,
## 이 경우 아래 read.table로 불러올 때 인식되지 않기 때문에 문자열을 인식시키기 위해 
## "\n\n"인 부분을 찾아 "\n_\n"으로 바꿔야 함. "\n\n"이 없을 때까지 시행
## 맨 마지막 행의 "_"는 삭제한 후 저장
## 언더바(_)는 아래에서 ""으로 변환

    # 5-1-5. 분절된 제목 데이터를 기존 df에 결합 ####
seg_text2 <- read.table('segtitle2.txt',sep = '\t',header = TRUE)

# 생성된 seg_text와 dfas의 행 갯수 확인, 두 숫자가 동일해야 결합 가능
nrow(seg_text2)
nrow(dfc2)

dfc2p<-cbind(dfc2, seg_text2) # dfc2p: 제목을 parsing한 데이터를 dfc2에 결합한 df
colnames(dfc2p)[colnames(dfc2p) == "seg_text2"] <- "seg_text"
dfc2p$seg_text <- gsub("_", "", dfc2p$seg_text) # 언더바("_")를 ""으로 변환

# View(dfc2p)
write.csv(dfc2p,"csv_base/dfc2p.csv")

    # 5-1-6. seg_text 단어 단위로 행을 분절,  ####
dfc2ps <- separate_rows(dfc2p, seg_text, sep = " ")
# View(dfc2ps)
write.csv(dfc2ps,"csv_base/dfc2ps.csv")

    # 5-1-7. 분절한 단어 중 한 글자 단어 정리
# 불용어로 설정한 단어 중 제거되지 않은 것과 
# 사용자 사전에 정의하지 못한 고유명사 등이 한 글자로 분절된 경우가 있음
# 남아있는 불용어와 정확하게 분절되지 않은 것을 삭제
dfc2ps <- dfc2ps %>%
  filter(nchar(seg_text) > 1)
write.csv(dfc2ps,"csv_base/dfc2ps(trimed).csv")

  # 5-2. journal,year,place별로 seg_text의 빈도를 계산 ####
nj_selected <- dfc2ps %>% select(seg_text,journal,author,year,place)

nj <- nj_selected %>%
  group_by(seg_text,journal,author,year,place) %>%
  summarise(weight = n()) %>%
  arrange(year, desc(weight))

nj$weight <- as.integer(nj$weight)

colnames(nj)[colnames(nj) == "seg_text"] <- "source"
colnames(nj)[colnames(nj) == "journal"] <- "target"

# 결과 출력, 비어있는데 비어있다고 인식되지 않는 칸을 강제로 결측값으로 변환하여 제거

# View(nj)
nj$target[nj$target == ""] <- NA
nj <- nj[complete.cases(nj), ]
write.csv(nj, 'csv_for_gephi/nj.csv', row.names = FALSE)

  # 5-3. 국민당, 공산당계 잡지 제외하고, 이를 이용해 csv파일 만들기 ####
nj_3rd <- nj %>%
  filter(target != "《中央周刊》",
         target != "《解放》",
         target != "《时代杂志》",
         target != "《正报》",
         target != "《群众》",
         target != "《文萃》")
write.csv(nj_3rd, file = 'csv_for_gephi/nj_3rd.csv', row.names = FALSE)

  # 5-4. 시계열(time serial) 분석을 위한 데이터 ####

    # 5-4-1. source 값에 year 추가 ####
## 원 csv 파일을 gephi에 탑재하면서 year 값을 무시하고 한 개체로 합쳐지고,
## 이 때 가장 큰 year 값만 남게 됨
## 연도별 시계열 분석을 진행할 때 값의 왜곡이 발생하므로, 
## 이를 해결하기 위해 source 값에 연도 정보를 추가

library(dplyr)

nj_ts <- nj %>%
  mutate(source = paste(source, "(", year, ")", sep = ""))
write.csv(nj_ts, file = 'csv_for_gephi/nj_ts.csv', row.names = FALSE)

nj_3rd_ts <- nj_3rd %>%
  mutate(source = paste(source, "(", year, ")", sep = ""))
write.csv(nj_3rd_ts, file = 'csv_for_gephi/nj_3rd_ts.csv', row.names = FALSE)

    # 5-4-2. Label 값 부여하기 ####
# source(및 target) 값에 붙인 year 값이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여

      # 5-4-2-1. nj_ts ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_nj_ts <- unique(nj_ts$source)
unique_t_nj_ts <- unique(nj_ts$target)

# lable 데이터프레임 생성
s_value_nj_ts <- gsub("\\(1945\\)$", "", unique_s_nj_ts)
s_value_nj_ts <- gsub("\\(1946\\)$", "", s_value_nj_ts)
s_value_nj_ts <- gsub("\\(1947\\)$", "", s_value_nj_ts)
s_value_nj_ts <- gsub("\\(1948\\)$", "", s_value_nj_ts)
s_value_nj_ts <- gsub("\\(1949\\)$", "", s_value_nj_ts)

nj_ts_n_lable <- data.frame(Id = c(unique_s_nj_ts),
                            Label = c(s_value_nj_ts),
                            type = rep("notion", length(unique_s_nj_ts)))

# 앞서 target 값에 붙여놨던 "(n)"이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여
nj_ts_j_lable <- data.frame(Id = c(unique_t_nj_ts),
                            Label = c(unique_t_nj_ts),
                            type = rep("journal", length(unique_t_nj_ts)))

nj_ts_lable <- rbind(nj_ts_n_lable, nj_ts_j_lable)
write.csv(nj_ts_lable, 'csv_for_gephi/nj_ts_lable.csv', row.names = FALSE)
## nj_ts.csv를 gephi에서 실행한 후 nj_ts_lable을 import spreadsheet로 적용

      # 5-4-2-2. nj_3rd_ts ####
# 중복 제거하여 각각 고유한 값들로 정리
unique_s_nj_3rd_ts <- unique(nj_3rd_ts$source)
unique_t_nj_3rd_ts <- unique(nj_3rd_ts$target)

# lable 데이터프레임 생성
s_value_nj_3rd_ts <- gsub("\\(1945\\)$", "", unique_s_nj_3rd_ts)
s_value_nj_3rd_ts <- gsub("\\(1946\\)$", "", s_value_nj_3rd_ts)
s_value_nj_3rd_ts <- gsub("\\(1947\\)$", "", s_value_nj_3rd_ts)
s_value_nj_3rd_ts <- gsub("\\(1948\\)$", "", s_value_nj_3rd_ts)
s_value_nj_3rd_ts <- gsub("\\(1949\\)$", "", s_value_nj_3rd_ts)

nj_3rd_ts_n_lable <- data.frame(Id = c(unique_s_nj_3rd_ts),
                                Label = c(s_value_nj_3rd_ts),
                                type = rep("notion", length(unique_s_nj_3rd_ts)))

# 앞서 target 값에 붙여놨던 "(n)"이 gephi에서 시각화할 때 보이지 않도록 Label 값 부여
nj_3rd_ts_j_lable <- data.frame(Id = c(unique_t_nj_3rd_ts),
                                Label = c(unique_t_nj_3rd_ts),
                                type = rep("journal", length(unique_t_nj_3rd_ts)))

nj_3rd_ts_lable <- rbind(nj_3rd_ts_n_lable, nj_3rd_ts_j_lable)
write.csv(nj_3rd_ts_lable, 'csv_for_gephi/nj_3rd_ts_lable.csv', row.names = FALSE)
## nj_3rd_ts.csv를 gephi에서 실행한 후 nj_3rd_ts_lable을 import spreadsheet로 적용

