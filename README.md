## 🎬 Cine21 Movie Ranking DB Modeling Project
- 씨네21의 영화 랭킹 데이터를 분석하여 영화 정보 및 비즈니스 관계를 체계적으로 관리하기 위한 관계형 데이터베이스(RDBMS) 설계 프로젝트입니다.
​

### 📌 Project Overview
- 기간: 2026. 01. 29 (1일 소규모 프로젝트)

- 도구: eXERD

- 목표: 영화 랭킹 시스템의 복잡한 다대다(N:M) 관계(감독, 장르 등)를 정규화하고, 비즈니스 로직에 최적화된 물리 모델 구축

### 🚀 Key Design Points (Refactoring)
#### 1. 명명 규칙 최적화 (Naming Convention)
명사형 중심 설계: 초기 DIRECTING, IMPORTING 등 동명사 형태의 테이블명을 DIRECTION, IMPORT 등의 명사형으로 전면 수정하여 엔티티의 정체성을 명확히 했습니다.
Snake Case 준수: 모든 물리명은 _를 활용하여 가독성을 높였습니다.

#### 2. 회사 엔티티 통합 및 비즈니스 타입 분류
Involvement 통합 모델: 제작사, 배급사, 제공사, 수입사가 동일한 회사(Company)인 경우가 많은 도메인 특성을 반영했습니다.

COMPANY & MOVIE_INVOLVEMENT: 회사는 하나로 관리하되, MOVIE_INVOLVEMENT 테이블의 TYPE 컬럼을 통해 해당 영화에서의 역할(제작, 배급, 제공, 수입)을 구분하여 데이터 중복을 최소화했습니다.

#### 3. 복합 관계 처리 (N:M Relationship)
다중 감독/장르 대응: 한 영화에 여러 감독이 참여하거나 여러 장르가 복합된 경우를 처리하기 위해 DIRECTION, MOVIE_GENRE 매핑 테이블을 사용하여 제1정규화를 준수했습니다.

시각 자료 대체: 사진/영상 파일 직접 저장 대신 YouTube Link 컬럼을 활용하여 데이터 효율성을 높였습니다.

### 📋 Task Process
- 사이트 분석: 씨네21 영화 랭킹 및 상세 페이지 데이터 속성 추출
- 논리 모델링: 엔티티 간 관계 설정 및 속성 정의
 - 물리 모델링: DB 성능을 고려한 데이터 타입(NUMBER, VARCHAR2 등) 및 제약 조건 설정
- DDL/DML: 테이블 생성 스크립트 작성 및 검증용 샘플 데이터(30개 이상) 추가
- 검증: 업무 규칙에 따른 데이터 무결성 테스트

##### 🗂 Database Schema (Major Tables)
- MOVIE: 영화 기본 정보 (Runtime: NUMBER 타입 관리)
- COMPANY: 제작/배급/제공/수입사 통합 정보
- BUSINESS: 영화-회사 간 참여 관계 및 역할(Type) 관리
- DIRECTION, APPEARANCE: 영화-감독, 영화-배우 매핑 관계
- ARTICLE: 기자/전문가 보도 기사
- *_REVIEW: 전문가, 고객 리뷰 매핑


##### ⚠️ Version Control
- 단기 프로젝트 특성상 별도의 형상 관리 도구(Git 등) 없이 단계별 파일 분할(v1.0, v1.1_Refactored 등)을 통해 이력을 관리함.



### 영화 데이터베이스 ERD 설계
#### 📊 데이터 계층 구조 (Depth)
##### 1 Depth - 기초 마스터 데이터
- 독립적인 코드/마스터 테이블로, 다른 테이블의 참조 대상이 되는 기본 정보입니다.

	- 국가 (COUNTRY)

	- 시놉시스 (SYNOPSIS)

	- 심의등급 (RATING)

- 2 Depth - 핵심 엔티티
1 Depth 데이터를 참조하여 구성되는 주요 비즈니스 개체입니다.

	- 영화 (MOVIE)

	- 영화 회사 (MOVIE_COMPANY)

	- 감독 (DIRECTOR)

	- 배우 (ACTOR)

	- 전문가 (EXPERT)

	- 고객 (CUSTOMER)

	- 장르 (GENRE)

	- 기자 (JOURNALIST)

- 3 Depth - 관계 및 상세 정보
2 Depth 엔티티 간의 다대다(N:M) 관계를 해소하거나, 상세 정보를 담는 테이블입니다.

	- 관련영화 (RELATED_MOVIE)

	- 대표자 (REPRESENTATIVE)

	- 서비스 (SERVICE)

	- 연출 (DIRECTING)

	- 출연 (CASTING)

	- 전문가리뷰 (EXPERT_REVIEW)

	- 고객리뷰 (CUSTOMER_REVIEW)

	- 영화장르 (MOVIE_GENRE)

	- 기사 (ARTICLE)

### 👤 담당 업무
#### 담당 테이블
-	시놉시스 (SYNOPSIS)

-	영화 회사 (MOVIE_COMPANY)

-	대표자 (REPRESENTATIVE)

-	서비스 (SERVICE)

#### 수행 작업
✅ DDL 작성

✅ DDL 충돌 확인 (FK 참조 순서 검증)

✅ DML 충돌 확인 (데이터 삭제 시 참조 무결성)

✅ DML 작성 및 병합

