## 사회 네트워크 분석을 통해 본 1940년대 후반 중국 언론 지형과 제3세력 </br> - 중국근현대사 디지털역사학 연구 시론 -  
### Third Force Journalism and their Political Status in Late 1940s China: </br> Utilizing Social Network Analysis in Modern Chinese History

</br>

## 논문 서지사항 및 링크
서강인문논총 제69집, 2024.04, 137~188쪽  
doi: <http://doi.org/10.37981/hjhrisu.2024.4.69.137>  
[KCI 링크](https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART003078367) / [DBPIA 링크](https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE11761454)

</br>

## 논문 목차

1. 머리말</br>
2. 자료 소개 및 전처리 방법</br>
3. 잡지 네트워크와 다원적 제3세력 공간</br>
4. 시계열 분석과 제3세력 정치 변동</br>
5. 맺음말

</br>

## 논문 개요

### \<Abstract\>


&nbsp;&nbsp;This study conducts a Social Network Analysis centered on authors and journals based on indexing data from magazines published from 1945 to 1949 to confirm the status of the third force in late 1940s China. It aims to identify the political statu s of the third force from their positions in the media landscape. Visu al examination of the data spanning the five-year period reveals that third force journals occupied a distinctive territory separate from those of the Nationalist Party (KMT) and the Commu nist Party of China (CCP) in the media landscape. The territory of third force journals can be categorized into politically-oriented journals in the center, liberalist journals in the lower right, and journals affiliated with the China Democratic League (CDL) in the lower left. Such categorization within the third force journals illustrates differences in tactics and specific orientations within the group based on affiliation, region, and period of activity. Through a time-series analysis conducted annually, this study examines changes in the status of journals and corresponding shifts in the media landscape during political turbulence from the Political Consultative Conference (PCC) to the Chinese Civil War. Finally, it discusses the reasons why the adoption of Digital History methods in the field of modern Chinese history remains insufficient, emphasizing the need for efforts in "Distant reading".
 
Keywords : Late 1940s, Third Force, Chinese Civil War, Social Network Analysis(SNA), Digital History(DHis)

</br>

### \<국문초록\>

&nbsp;&nbsp;이 논문은 1940년대 후반 중국 제3세력의 위상을 확인하기 위해, 1945년부터 1949 년까지 발행된 잡지의 색인 데이터를 바탕으로, 저자와 잡지를 중심으로 한 사회 네트 워크 분석을 시행한다. 지식인으로서 언론을 통한 정치 담론 생산과 여론 호소가 정치 활동의 주를 이뤘던 제3세력의 성격과 관련해, 언론 지형 속 위치로부터 그들의 정치적 위상을 확인하고자 한다.</br>
&nbsp;&nbsp;5년 전체 시기의 데이터를 시각화하면 당시 언론 지형에서 제3세력 잡지가 국공 양당 잡지와 구분되는 독자적인 영역을 차지했음을 확인할 수 있다. 제3세력 잡지 영역은 중심부, 우측 하단, 좌측 하단으로 나눌 수 있는데, 중심부에는 정치 결사 중심 잡지, 우측 하단에는 자유주의 성향 잡지, 좌측 하단에는 민주동맹 계열 잡지가 위치한다. 이 같은 분화는 소속 단체, 지역, 활동 시기 등에 따라 제3세력 내에서도 실천 방식과 구체적인 지향에 차이가 존재했음을 보여준다.</br>
&nbsp;&nbsp;이어서 1년 단위 시계열 분석을 시행하여, 정협에서 내전 격화로 이어지는 정치 변동 속에 나타난 잡지별 위상 변화와 그에 따른 언론 지형의 변동 양상을 검토했다. 제 3세력 잡지 내에서 1946년 이전에는 정치 결사를 중심으로 한 잡지가, 1947년 이후에는 자유주의 성향의 잡지가 주류를 차지한다. 제3세력 잡지와 국공 양당 잡지 간의 관계 변화도 확인할 수 있다.</br>
&nbsp;&nbsp;끝으로 본 연구의 한계점으로부터 중국근현대사 분야의 디지털역사학 방법론 도입이 여전히 활발하지 못한 이유를 논하고, 그럼에도 ‘멀리서 읽기’ 시도가 이루어질 필요성을 제기한다.

주제어 : 1940년대 후반, 제3세력, 국공내전, 사회 네트워크 분석, 디지털역사학


</br>

## 코드 소개

### 3rdnetrawdata.ipynb: 1단계 전처리 코드(python)
全國報刊索引에서 50개 단위로 다운로드한 목차 파일을 하나로 합치는 python 코드 및 Sublime Text를 이용한 자료 정리 방법에 대한 설명을 포함하는 jupiter notebook

### 3rdForceNetwork.R: 2단계 및 3단계 전처리 코드(R)
2단계에서는 모든 잡지의 데이터를 하나의 통합 데이터로 결합하고, 기계 조작 시 발생할 수 있는 오류를 최소화하기 위해 문자열을 처리한다. 3단계에서는 통합 데이터를 활용해 네트워크 분석용 데이터를 만든다. 

### 3rdForceNetwork(analysis).R: 데이터 분석(또는 그것을 위한 전처리)을 위한 코드
논문에서 이미 다룬 내용을 포함해, 1940년대 중국 제3세력 언론 데이터셋에 대한 초보적인 데이터 분석(또는 그것을 위한 전처리)을 위한 코드를 담고 있으며, 새로운 분석 코드를 작성할 때마다 업데이트 예정

</br>

## 자료 소개

### a) rawdata: 원자료

&nbsp;&nbsp;자료로는 『全國報刊索引』 온라인 플랫폼을 통해 이용할 수 있는 『民國時期期刊全文數據庫』(이하 『민국DB』)의 잡지 색인을 활용한다. 주요 분석 대상인 제3세력 잡지 총 20종을 선정하고, 국민당 기관지 『中央週刊』과 공산당 계열 잡지 총 5 종을 비교군으로 삼는다. 이처럼 많은 종류의 잡지를 함께 분석 하는 이유는, 한 인물 또는 한 정당을 단위로 한 연구가 주를 이뤘던 기존 제3세력 연구의 한계를 극복하기 위해서다. 하나의 대상을 단위로 한연구는 그에 대한 깊이 있는 연구가 가능하지만, 각각의 저작이 자기완결성을 갖기 때문에, 제3세력 전체, 나아가 국공 양당을 포함하는 정치 공간 전체에서 그 대상이 어느 정도의 위상을 차지하는지는 확인하기 어렵다. 이러한 한계를 극복하고 제3세력 전체에 걸쳐 일관된 분석을 시행하기 위해서는, 특정 인물, 특정 정당, 특정 잡지 어느 하나를 중심으로 하기보다 제3세력 인물들이 관계된 다양한 잡지를 같은 체계 안에서 정리 하고 분석할 필요가 있다. 본 연구는 디지털 기술을 활용해, 전통적인 정성적 방법론으로는 일관되게 다루기 어려운 대량의 데이터를 수집, 정리, 분석하여 기존 연구의 한계를 보완하고자 한다.</br>
&nbsp;&nbsp;분석 대상 잡지의 선정은 우선 중국 제3세력에 관한 고전적 연구인 기쿠치 다카하루(菊池貴晴)의 『中国第三勢力史論』의 각 장을 구성하는 인물, 즉 황옌페이(黃炎培), 장쥔마이(張君勱), 량수밍(梁漱溟), 션쥔루(沈鈞儒), 쩡치(曾琦), 그리고 서남연합대학(西南聯合大學)의 판광단(潘光旦), 페이샤오퉁(費孝通), 뤄룽지(羅隆基) 등의 이름을 『민국DB』에 검색해 이들이 자주 기고하는 잡지를 선별한다. 추가로 나카무라 모토야가 정리한 “공산당 및 좌파계 유력지의 발행 상황” 에 언급된 잡지 중 『민국DB』에서 확보할 수 있는 것들을 위주로 활용한다. 해당 목록은 제3세력 잡지와 공산당계 잡지를 함께 제시하고 있는데, 이를 구분하는 데에는 필진 구성 및 『민국DB』가 제공하는 잡지 소개를 참고한다. 《時代雜誌》의 경우 공산당･소련계 신문인 《時代日報》를 발행하는 蘇商時代雜誌社의 주간지로, 소련 저작의 번역물이 큰 비중을 차지하고 있어 공산당계로 구분하는 데 어려움이 없다. 『민국DB』에 중국공산당과 해방군 정책을 소개하는 간행물로 소개된 《正報》, 군중에게 공산당에 의한 중국 해방의 정당성을 보여주었다고 소개된 《群衆》, 화북 지역 해방구의 상황 및 동북 문제에 대해 다루었 다고 소개된 《解放》 역시 공산당계 잡지로 구분한다. 《群衆》과 함께 공산당계 잡지로 언급되는 《文萃》의 경우, 필진에 있어서는 기타 공산당계 잡지보다는 제3세력 잡지와 겹치는 부분이 많지만, 멍추장(孟秋江), 지시잉(計惜英), 리슈(黎澍) 등 공산당원 언론인들이 편집을 맡아 당의 지시를 받으며 운영한 정황을 고려해 공산당계 잡지로 분류한다. 선정한 잡지 총 26종에 대해서는 1945년부터 1949년까지의 색인 텍스트 데이터를 『민국DB』에서 추출하고, 전처리를 거쳐 네트워크 분석에 활용할 수 있는 원자료(raw data)를 생성한다.[141~145쪽]

* 각 폴더명이 지칭하는 잡지</br>

  * 제3세력 잡지: </br> gc-觀察, gmb-光明報, gx-國訊, mzbp-民主周刊(北平), mzcq-民主(重慶), mzgl-民主:桂林版, mzkm-民主周刊(昆明), mzsh-民主(上海), syw-時与文, xdwz-現代文摘(上海), xl-新路周刊, zb-周報(上海1945), zhlt-中華論壇, zj-中建, zjbp-中建:北平版, zjhbhk-中建:華北航空版, zjzh-中建:綜合版, zl-主流, zs-再生, zw-展望

  * 국공양당 잡지: </br> zyzk-中央周刊 / jf-解放, qz-群眾, sdzz-時代雜誌, wc-文萃, zbcom-正報


### b) csv_journal: 1단계 전처리 결과물

&nbsp;&nbsp;전처리는 크게 세 단계로 구분할 수 있다. 1단계에서는 『민국DB』에서 추출한 잡지별 색인 텍스트 데이터에서 항목명을 제거하고 줄바꿈을 쉼표로 바꾸어 기계 처리에 적합한 csv(쉼표로 구분된 값 파일) 형식으로 정리한다.[145쪽]


### c) csv_base: 2단계 전처리 결과물

&nbsp;&nbsp;2단계에서는 모든 잡지의 데이터를 하나의 통합 데이터로 결합하고, 기계 조작 시 발생할수 있는 오류를 최소화하기 위해 문자열을 처리한다. 예를 들어 저자의 본명 외에 이명이나 필명, 또는 성을 제외한 이름만 기재된 경우, 또는 PDF 원문과의 대조 등을 통해 확인할 수 있는 명백한 오기 등이 존재한다. 인물 중심 네트워크 분석의 정확도를 높이기 위해서는 동일 인물을 가리키는 여러 표기를 하나의 대표 이름으로 통일할 필요가 있다. 또한 DB에서 제공하는 데이터는 기본적으로 간체 중문을 채택하고 있으나, 일부 번체 중문을 포함한 기사도 적지 않다. 컴퓨터는 같은 글자의 간체와 번체를 서로 다른 글자로 인식하기 때문에, 정확한 분석을 위해서는 둘 중 하나로 통일할 필요가 있는데, 본 연구의 데이터는 간체를 번체로 바꾸면서 발생할 수 있는 오변경을 최소화하고자 간체로 통일한다. 이때 DB에서 가져온 원 저자명과 원 기사 제목은 원문 대조가 필요한 경우를 고려해 별도의 열 이름(“author_raw”, “title_raw”)을 붙여 데이터 뒤쪽에 결합한다.[145쪽]</br>
&nbsp;&nbsp;"(trimmed)" 파일은 저자명 또는 기사제목을 분절한 어휘 중 한 글자로 이루어진 것을 제외한 데이터다. 저자명이 한 글자일 경우 복수의 서로 다른 저자를 지칭할 수 있고, 한 글자로 이루어진 어휘의 경우 조사나 부사, 또는 사용자 사전과 불용어 사전의 불완전함으로 잘못 분절된 경우가 많아, 보다 정확한 분석을 위해 이를 제외한 데이터를 따로 생성한다. 또한 이를 통해 용량이 비교적 큰 dfas와 dfasps, dfc2ps 데이터를 간소화하여 gephi에서 값을 계산할 때 드는 시간을 줄일 수 있다.


### d) csv_for_gephi: 3단계 전처리 결과물

&nbsp;&nbsp;3단계에서는 통합 데이터를 활용해 네트워크 분석용 데이터를 만든다. 확보한 색인 데이터의 각 기사는 기본적으로 제목, 저자, 잡지의 세 가지 속성을 가진다. 2단계 처리를 거친 색인 정보 중 “政治协商会议与国防新案, 張東蓀, 民主周刊(昆明), 1945, 第2卷 第22期, 11-12”라는 개체를 예로 들어 보자. 16) 해당 정보는 ‘張東蓀’(저자)의 ｢政治协商会议与国防新案｣(기사)가 《民主周刊(昆明)》(잡지)에 실린 사실을 나타낸다. 이 정보를 네트워크 분석의 방식으로 이해하면, ‘张东蓀’과 ‘《民主周刊(昆明)》’를 각각 하나의 점(노드, node)으로, 기사가 실린 사실은 두 점을 연결하는 선(에지, edge)으로 볼 수 있다. 네트워크 분석용 데이터의 생성은 주어진 정보를 “source”(출발점)와 “target”(도착점)으로 구성된 에지의 표현 형식으로 가공하는 작업이다. 이 작업에서 특히 주목해야 할 것은 “weight”(가중치) 다. 가중치는 네트워크에서 두 노드의 관계가 얼마나 긴밀한지를 보여주고, 네트워크를 시각화할 때는 점과 점을 잇는 선의 굵기를 결정하는 중요한 변수로 작용한다. 여기에서는 한 저자의 기사가 특정 잡지에 실린 횟수를 가중치로 설정할 수 있다.[146\~147쪽]</br>
&nbsp;&nbsp;파일명은 해당 네트워크 데이터의 출발점과 도착점이 각각 무엇으로 이루어져 있는지를 알려준다. "aj" 데이터는 저자(author)를 출발점, 잡지(journal)를 도착점으로 하며, "an"은 저자를 출발점, 어휘/개념(notion)을 도착점으로 하고, "nj" 데이터는 어휘/개념을 출발점, 잡지를 도착점으로 한다. "_3rd"가 붙은 데이터는 제3세력 잡지 기사만을 대상으로 한 것이다. "_ts"가 붙은 데이터는 시계열 분석을 위해 출발점에 해당하는 저자명 또는 어휘 값에 연도를 나타내는 "(yyyy)" 형태의 문자열을 붙인 것이다. 다만 그래프에 구태여 연도 정보를 나타나게 할 필요는 없으므로, Gephi 탑재에 앞서 데이터에 Label 열을 추가해 각 행의 source에서 "(yyyy)" 문자열을 뗀 원래의 저자명을 입력한다. 이러한 과정을 거쳐 만든 시계열 분석용 csv 데이터는 Gephi의 필터 (Filters) 기능과 통계(Statistics) 기능을 활용해 연도별 데이터를 추출해 시각화 결과물을 만들 수 있다.[169\~170쪽]


### e) attributes_to_gephi: 속성 데이터

&nbsp;&nbsp;Gephi에서 "import spreadsheet" 기능을 사용해 각 개체에 속성을 부여하기 위한 데이터로, 용도와 사용 방법은 다음과 같다.

&nbsp;&nbsp;journal_type: 시각화 결과물에서 저자 또는 어휘 노드를 잡지 노드와 구분하기 위해, 잡지 노드에 해당하는 ID에 type 속성에 잡지임을 나타내는 속성값 "journal"과 Give Colors To Nodes 플러그인으로 노드 색상을 부여하기 위한 16진수 색상코드를 부여한 데이터.  
(1) Gephi에 네트워크 데이터를 탑재한 이후 Data Laboratory에서 "Add column" 기능으로 "type"(, "type2"), "color" 속성을 추가한다.  
(2) "Fill column with a value" 기능으로 모든 개체의 "type"(, "type2") 속성을 "author" 또는 "notion"으로 채우고, "color" 속성을 임의의 색상코드(형식: #000000)로 채운다.  
(3) "import spreadsheet" 기능으로 "journal_type.xlsx" 파일을 추가하면 잡지 노드의 "type" 값과 "color" 값이 부여된다.  
(4) "journal_type" 데이터는 제3세력 잡지와 국공양당 잡지를 모두 포함하며, "type" 속성에 대해 국민당 잡지에 "journal(n)", 공산당 잡지에 "journal(c)", 그 외 제3세력 잡지에 "journal"의 속성값을 부여하되, 분석 과정 중 2 mode 그래프의 1 mode 변환과 같이 잡지 간 유형 구분이 필요하지 않은 경우가 있어 "type2" 속성을 따로 만들고 모든 노드에 "journal" 속성값을 부여한다. "journal_type_3rd"는 제3세력 잡지만을 포함하여 잡지 간 유형 차이가 없으므로 "type" 속성만을 갖는다.  
  
&nbsp;&nbsp;type_an: an 데이터에서 인명이 기사 제목에 포함된 경우가 있어, 저자 노드와 어휘 노드가 한 노드로 합쳐지지 않도록 target 값에 "(n)"을 추가하고, 그래프에서는 "(n)"이 나타나지 않도록 Label 열을 추가해 원래의 저자명을 속성값으로 부여한 데이터. 이 데이터는 source와 target으로 이루어진 에지 데이터에서 source 값과 target 값을 각각 추출하여 중복을 제거한 후 rbind 함수로 결합해 노드 데이터의 형태로 만들며, 이 과정에서 source 추출값과 target 추출값 각각의 type 속성값을 부여할 수 있어 type 속성도 포함한다. "import spreadsheet" 기능으로 파일을 추가하면 label 속성에 속성값이 부여되고, 속성값을 가진 type 열이 생성된다.  

&nbsp;&nbsp;label_OO_ts: 시계열 분석을 위해 source값에 연도를 나타내는 "(yyyy)" 형태의 문자열을 붙인 데이터에 대해, 그래프에서 연도 정보가 나타나지 않도록 Label 열을 추가해 "(yyyy)" 문자열을 뗀 원래의 저자명을 속성값으로 부여한 데이터. 이 데이터 역시 에지 데이터를 노드 데이터의 형태로 변환하는 과정에서 type 속성을 추가했다. "import spreadsheet" 기능으로 파일을 추가하면 label 속성에 속성값이 부여되고, 속성값을 가진 type 열이 생성된다.


### f) visualization: 시각화 결과물


### g) gephi_tables: Gephi 통계 분석 결과물  

&nbsp;&nbsp;3단계 전처리 결과물을 Gephi에 탑재하면 Gephi의 통계 분석 기능을 활용해 중심성 등을 계산할 수 있다. 본 폴더에는 논문 작성에 직접적으로 관계된 데이터만을 포함하고, 연구 과정에서 생성되었으나 논문에 직접적으로 관련되지 않은 데이터는 별도 폴더(gephi_tables_sub)로 업로드한다.</br>
&nbsp;&nbsp;Gephi의 통계 분석은 Gephi를 실행했을 때 처음 나타나는 Overview 창의 왼쪽 탭 중 Statistics에서 시행할 수 있다. Average Degree(평균 연결 정도)는 각 노드가 몇 개의 노드와 연결되어 있는지를 계산해 평균 낸 값으로, Run을 클릭하면 Average Degree 값과 함께 Data Laboratory에서 확인할 수 있는 각 노드의 Degree(연결 정도) 값을 생성한다. Avg Weighted Degree(평균 가중치 연결 정도)는 각 노드와 연결된 에지의 가중치 합을 계산하고 이를 평균 낸 값이다. Network Diameter(네트워크 최단거리)는네트워크 안에서 서로 가장 멀리 떨어져 있는 노드를 잇는 최단 거리(최소 에지 개수)를 계산하며, 이를 통해 Betweenness Centrality(매개 중심성), Closeness Centrality (근접 중심성) 등의 중심성 지표를 얻을 수 있다. Eigenvector Centrality(고유 벡터 중심성)는 단순히 얼마나 많은 노드에 연결되었는지 뿐 아니라, 연결된 노드가 네트워크 안에서 얼마나 중요한 노드인지까지 고려해 계산하는 종합 중심성 수치를 계산 한다. 각각의 주요 중심성에 대한 설명은 윤종훈, ｢07-1. 사회네트워크 분석이란?｣, ｢사회네트워크 분석과 Gephi－기초｣, 김바로, 전가람, 이효림 외 4명, 『인문 데이터 분석－디지털인문학 시리즈』(<https://wikidocs.net/192599>, 최종 편집: 2024년 3월 19일 20:02)를 참조.[149쪽]


### h) gephi_tables_sub: 통계 분석 결과물(논문 외)  

&nbsp;&nbsp;해당 폴더에는 연구 과정에서 생성되었으나 논문에 직접적으로 관련되지 않은 데이터를 업로드한다. 여기에는 Gephi에서 데이터셋에 대해 시행한 각종 통계 분석 데이터를 일괄 Export한 csv 파일과 함께, 그 데이터를 활용해 R언어 환경에서 데이터 분석을 시도한 중간 결과물도 포함한다. 향후 분석 코드(3rdForceNetwork(analysis).R)의 업데이트와 함께 생성한 분석 결과도 추가할 예정이다. 다만, Gephi 통계 분석 데이터 중 아래 네 가지 데이터는 Github에 탑재할 수 있는 최대 용량을 초과해 업로드하지 못했다. 필요시 classtoy@naver.com 또는 issues 문의를 통해 제공 가능하다.  
- aa_aj_edges.csv  
- aa_aj_3rd_edges.csv  
- nn_nj_3rd_edges.csv  
- nn_nj_3rd(degree2up)_edges.csv

</br>

## 통계 분석 설명

### Gephi 통계 분석 개요

&nbsp;&nbsp;Gephi의 통계 분석은 Gephi 실행 시 처음 나타나는 Overview의 왼쪽 탭 중 Statistics에서 시행할 수 있다. Average Degree(평균 연결 정도)는 각 노드에 연결된 노드 수의 평균값으로, Run을 클릭하면 이 값과 함께 Data Laboratory에서 확인할 수 있는 노드별 Degree(연결 정도) 값을 생성한다. Avg Weighted Degree(평균 가중치 연결 정도)는 각 노드와 연결된 에지의 가중치를 합산하여 평균 낸 값이다. Network Diameter(네트워크 최단 거리)는 네트워크 안에서 서로 가장 멀리 떨어진 노드를 잇는 최단 거리(최소 에지 개수)를 계산하며, 이를 통해 Betweenness Centrality(매개 중심성), Closeness Centrality(근접 중심성) 등의 지표를 얻을 수 있다. Eigenvector Centrality(고유 벡터 중심성)는 단순히 한 노드가 얼마나 많은 노드에 연결되었는지 뿐 아니라, 연결된 상대 노드가 전체 네트워크 안에서 얼마나 중요한 노드인지까지 고려한 종합 중심성 수치이다. 각각의 주요 중심성에 대한 설명은 윤종훈, ｢07-1. 사회네트워크 분석이란?｣, ｢사회네트워크 분석과 Gephi－기초｣, 김바로, 전가람, 이효림 외 4명, 『인문 데이터 분석－디지털인문학 시리즈』(<https://wikidocs.net/192599>, 최종 편집: 2024년 3월 19일 20:02)를 참조.[148쪽의 각주 19) 일부 수정]


### 방향성 설정

&nbsp;&nbsp;Gephi에서는 데이터를 Gephi에 탑재할 때와 방향성이 있는 네트워크에 대해 중심성 계산을 시행할 때 방향성 유무(directed/undirected)를 선택할 수 있다. 본 연구에서는 저자가 잡지에 글을 기고하는 행위 외에 별도의 관계 유형을 고려하지 않기 때문에, 연결의 방향성을 고려할 필요는 없다고 판단하여 기본 네트워크 성격을 undirected로 설정해 분석을 진행한다.[148쪽의 각주 20) 일부 수정]


### 2-mode 네트워크의 1-mode 네트워크 전환

&nbsp;&nbsp;Multimode Networks Transformation Plugin은 Gephi 0.10.1에서 기본 제공하는 플러그인으로, 두 속성으로 이루어진 그래프를 한 속성만 가진 그래프로 변환하는 데 사용한다. 변환 과정에서는 서로 다른 속성의 노드를 연결하는 에지 가중치에 대한 행렬 곱셈을 통해 새로운 가중치를 가진 엣지를 생성한다.  

예를 들어 세 명의 저자와 두 종의 잡지로 이루어진 저자–잡지 네트워크를 저자 네트워크로 변환할 경우, </br>
주어진 데이터를 3×2 행렬값으로 삼아,
![image](https://github.com/user-attachments/assets/8a85189d-676f-4341-9160-d17440b58cf8)
 그 전치행렬
![image](https://github.com/user-attachments/assets/67ab5b46-78f2-4e92-8f38-88c549a52c65)
과 행렬 곱셈을 실행한다.


![image](https://github.com/user-attachments/assets/0554d095-7eec-4daa-9aa5-086185720bd1)

이때 대각선의 값(6561, 36, 533)은 저자 자신의 가중치가 이중 계산된 값으로, 새로운 에지 생성에는 반영되지 않는다. 유의미한 값은 a12=a21=0, a13=a31=162, a23=a32=138 뿐이며, 이 중에서 값이 0인 항은 두 저자 간에 에지가 생성되지 않는다. 결과적으로 '張君勱–張東蓀'(Weight: 162), '張東蓀–施復亮'(Weight: 138)의 두 에지가 생성된다.


![image](https://github.com/user-attachments/assets/4cfe832b-01df-4093-bc8f-745b7da9119f)

&nbsp;&nbsp;이 같은 변환을 위해 상단 바의 도구-플러그인 탭에서 플러그인을 설치하면 Overview
또는 Data Laboratory 창 오른쪽에서 Multimode Networks Projection 창을 확인할 수
있다. 창에서 Load Attribute를 클릭해 해당 그래프가 가진 속성을 불러온 후 Attribute
Type에서 기준으로 삼을 속성을 선택하면 아래 Left matrix에 두 개의 하위 속성으로
만들 수 있는 행렬이 선택지로 표시된다. 이 행렬 중에 변환의 목표가 되는 속성이
앞에 적혀 있고 매개가 될 속성이 뒤에 적힌 행렬을 선택하고, Right matrix에서는 반
대로 매개 속성이 앞, 목표 속성이 뒤에 적힌 행렬을 선택한 후 Run을 클릭해 실행한
다. 예를 들어 ‘type’이라는 속성에 대해 각 노드가 ‘author’ 또는 ‘journal’라는 속성값
을 가진 경우, Left matrix에서 ‘author-journal’, Right matrix에서 ‘journal-author’를 선
택하여 실행하면, 속성값이 ‘author’인 노드 간에 위와 같은 계산을 통해 도출된 가중
치를 가진 에지가 생성된다. 반대로 Left matrix에서 ‘journal-author’, Right matrix에서
‘author- journal’를 선택해 실행하면, 속성값이 ‘journal’인 노드 간에 새로운 에지가
생성된다. 변환에 걸리는 시간은 새로 생성되는 에지의 수에 비례하는데, 목표 속성
을 가진 노드가 많을수록 생성해야 할 에지도 많아져 소요 시간이 길어진다. 해당 속
성의 노드가 너무 많아 계산 시간이 길어질 우려가 있으면, Threshold 값을 조정해 가중치가 낮은 에지를 계산에서 제외해 시간을 단축할 수 있다. 해당 플러그인에 대
한 정보는 https://Gephi.org/plugins/#/plugin/multimode (최종 편집: 2023년 1월 9일)
를 참조.[152-153쪽의 각주 24)]
