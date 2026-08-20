# SchoolStock 📈 — 학교 모의 주식투자 플랫폼 (1차 스프린트)

> 학생이 선생님에게 받은 포인트로 모의 주식을 사고팔며 투자를 배우는 웹 서비스.
> **Servlet/JSP 기반 Model 2 MVC**에 Command · Factory · Singleton 패턴을 적용해 도메인과 핵심 기능을 구축했습니다. *(이 구조를 같은 저장소의 [`main`](../../tree/main) 브랜치에서 MyBatis로 리팩토링했습니다.)*

<p>
  <img src="https://img.shields.io/badge/Java-8-007396?logo=openjdk&logoColor=white">
  <img src="https://img.shields.io/badge/Servlet%2FJSP-CC0000">
  <img src="https://img.shields.io/badge/Oracle_XE-F80000?logo=oracle&logoColor=white">
  <img src="https://img.shields.io/badge/MyBatis-3.2.3-000000">
  <img src="https://img.shields.io/badge/Apache%20Tomcat-8.0-F8DC75?logo=apachetomcat&logoColor=black">
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black">
  <img src="https://img.shields.io/badge/Bootstrap-4.6-7952B3?logo=bootstrap&logoColor=white">
  <img src="https://img.shields.io/badge/JUnit-4-25A162">
</p>

| 브랜치 | 내용 |
|---|---|
| [`sprint1-jdbc`](../../tree/sprint1-jdbc) | 1차 스프린트 완성본 · 순수 JDBC |
| [`main`](../../tree/main) | 리팩토링 완료본 · MyBatis 전환 |

**원본 저장소** — [Inhwa1003/1st_SchoolStock](https://github.com/Inhwa1003/1st_SchoolStock) · [내가 올린 PR 17건](https://github.com/Inhwa1003/1st_SchoolStock/pulls?q=is%3Apr+author%3Agitdong95)

---

## 📌 프로젝트 개요

| 항목 | 내용 |
|---|---|
| **개발 기간** | 1차 스프린트 · **2026.04.13 ~ 05.04** |
| **개발 기간** | MyBatis 리팩토링 · **2026.05.04 ~ 05.24** |
| **개발 형태** | 팀 프로젝트 · 애자일(스프린트) 기반 · 이슈 번호 브랜치 → PR → 리뷰 → 머지 |
| **진행 방식** | Servlet/JSP 기반 **Model 2 MVC** · Command / Factory / Singleton 패턴 적용 |
| **내 담당** | 주식 상세 — **매수·매도 체결** |
| **핵심 목표** | MVC 계층 분리 · 트랜잭션 경계 설계 · DAO 인터페이스 도입 · JDBC → MyBatis 이관 |

---

## 🏗️ 시스템 아키텍처

**1차 — 순수 JDBC**

![1차 아키텍처](docs/images/architecture-sprint1.png)

> **FrontController + Command 패턴**의 Model 2 MVC 구조입니다.
> `FrontControllerServlet` 하나가 모든 요청을 받고, `ActionFactory`가 `cmd` 값에 맞는 `Action`을 생성·실행해 **요청 분기와 비즈니스 처리를 분리**했습니다.

| 계층 | 구성 요소 | 패턴 | 역할 |
|---|---|---|---|
| **Controller** | `FrontControllerServlet` · `ActionFactory` | **Factory** | 모든 요청의 단일 진입점, `cmd` 기반 Action 분기 |
| **Command** | `Action` 인터페이스 + 구현체 **23개** | **Command** | 요청 하나 = 클래스 하나, `execute(req)` 단일 메서드 |
| **Persistence** | DAO **7개** · `DBCP` | **Singleton** | 조회·저장 + 트랜잭션 경계까지 담당 (Service 계층 없음) |
| **Model** | VO **8개** · `query` SQL 상수 **7개** | — | 테이블 매핑 객체 · SQL 분리 |
| **View** | JSP **13개** · Gson | — | 서버 렌더링 · Ajax 응답 JSON 직렬화 |

**리팩토링 — MyBatis 이관**

![리팩토링 아키텍처](docs/images/architecture-refactor.png)

> DAO 인터페이스를 두어 구현을 갈아끼울 자리를 만들고, `SqlSession`에 자원·트랜잭션 관리를 넘겼습니다.

| 항목 | 1차 (`sprint1-jdbc`) | 리팩토링 (`main`) |
|---|---|---|
| DAO 구조 | 구현 클래스 직접 사용 | **인터페이스 7개** + `DAOJdbc` / `DAOMyBatis` |
| 자원·트랜잭션 | `Connection` 직접 관리 | **`SqlSession`** 이 담당 |
| SQL 위치 | Java 상수 **23개** | **Mapper XML 7개** |
| `StockDetail` 메서드 수 | **37개** | **24개** |
| `Connection` 오버로딩 | **12쌍** | **0** |
| DAO 단위 테스트 | 7개 | **14개** (JDBC 7 + MyBatis 7) |

---

## 🗄️ 데이터베이스 설계 (ERD)

![ERD](docs/images/erd.png)

| 테이블 | 설명 |
|---|---|
| **`students`** | 학생 · 보유 포인트 · 보유 쿠폰 수 |
| **`stocks`** | 종목 · 발행가 · 발행잔량 · 이전가격 |
| **`orders`** | 주문 요청 (매수/매도 · 대기/체결/취소) |
| **`transaction`** | 체결 내역 (매수주문번호 ↔ 매도주문번호) |
| **`coupons` · `coupon_purchase`** | 쿠폰 · 구매 내역 |
| **`news`** | 종목 뉴스 |
| **`get_point`** | 포인트 지급 내역 |

> 보유 주식을 담는 테이블이 없습니다. 보유 수량은 체결된 주문의 **매수 − 매도 합계**로 계산합니다.

---

## 🧩 주요 기능

| 도메인 | 기능 |
|---|---|
| 📈 **주식 상세 (담당)** | **매수·매도 주문, 체결/대기/취소, 호가 조회, 내 주문 관리** |
| 📊 **주식 목록** | 시세 조회, 등락률, 폴링 갱신 |
| 👤 **회원** | 회원가입, 로그인, 중복 확인 (Ajax) |
| 💰 **내 자산** | 보유 주식·포인트 조회 |
| 🎟️ **쿠폰** | 쿠폰 상점, 구매, 사용 |
| 🧾 **포인트 내역** | 지급 내역 조회 |
| 📰 **뉴스** | 종목 뉴스 조회 |

---

## 🛠️ 기술 스택

| 구분 | 기술 |
|---|---|
| **Language** | Java 8 (`jdk1.8.0_71`) |
| **Backend** | Servlet 3.0 · JSP · JSTL 1.2 · Model 2 MVC (FrontController + Command) |
| **Persistence** | JDBC (`ojdbc5`) → **MyBatis 3.2.3** |
| **View / Async** | JSP · CSS · JavaScript · Bootstrap 4.6 · Gson 2.8.9 (JSON) |
| **Database** | Oracle XE |
| **Server** | Apache Tomcat 8.0 |
| **Build / Tool** | Git/GitHub · JUnit 4 |

---

## ✨ 주요 구현 포인트

- **Front Controller + Command 패턴** — 진입점은 서블릿 하나. 요청 하나가 클래스 하나(`Action` 23개)에 대응하고, 분기는 `ActionFactory`의 `case` 23건에 모여 기능 추가 시 `Action` 구현만으로 확장됩니다
- **3단계 체결 분기** — 발행잔량 매수 → 학생 간 매칭 → 대기 등록. 발행잔량이 남아 있는 동안에는 학생 간 거래가 열리지 않습니다
- **DAO가 트랜잭션 경계를 직접 관리** — Service 계층이 없어 쓰기 4개를 `setAutoCommit(false)` ~ `commit()` 으로 묶었습니다
- **`FOR UPDATE`로 이중 체결 차단** — 같은 매도 주문에 두 명이 동시에 매수를 걸면 한 건이 두 번 체결됩니다. 매칭 대상 행을 잠가 직렬화했습니다
- **인터페이스 기반 계층 분리** — DAO 인터페이스로 계약을 고정해 구현을 갈아끼울 자리를 만들고, 이를 활용해 **순수 JDBC DAO → MyBatis DAO로 점진 이관**
- **SQL 분리 관리** — `query` 클래스 상수 23개 → **Mapper XML 7개**로 이관

<details>
<summary>트랜잭션 경계와 <code>FOR UPDATE</code> 코드 보기</summary>

```java
conn.setAutoCommit(false);
    setStockPubBalance(conn, buyAmount, stockNo);    // 발행잔량 차감
    setOrderRequest(conn, "매수", ..., "체결", ...);  // 주문 등록
    setMatchedOrder(conn, ...);                       // 체결 기록
    setStudentPointDown(conn, ...);                   // 포인트 차감
    conn.commit();
} catch (Exception e) {
    conn.rollback();
}
```

쓰기 네 개가 하나로 묶여야 합니다. 하나라도 실패하면 포인트만 빠져나가거나 발행잔량만 줄어듭니다.

```sql
SELECT ... FROM (
  SELECT ... FROM orders
  WHERE ... AND state = '대기'
  ORDER BY price, order_date
) WHERE ROWNUM = 1
FOR UPDATE
```

</details>

---

## 🚀 실행 방법

**필요한 것** — JDK 8+ · Apache Tomcat 8+ · Oracle XE

```bash
# 1. 저장소 클론
git clone https://github.com/gitdong95/1st_SchoolStock.git

# 2. DB 준비 — db/ 의 스크립트를 순서대로 실행 (Oracle XE)
#    schema.sql      테이블 8개 · PK · FK
#    sequences.sql   시퀀스 7개   ※ CREATE 부분만 실행 (아래 DROP은 재실행용)
#    data.sql        학생 8명 · 종목 10개 · 쿠폰 3개
#    data-news.sql   뉴스 더미 데이터

# 3. 접속 정보 수정
#    src/com/school/stockGame/dao/jdbc/DBCP.java   JDBC URL · 계정
#    src/config/mybatis-Config.xml                 MyBatis URL · 계정

# 4. Tomcat 배포 후 http://localhost:5432/StockGame/ 접속
```

**시연 계정** — `kjw050101` / `1234` (학생 8명 모두 비밀번호 동일)

종목마다 발행잔량이 10주씩 있습니다. 매수하면 **발행가로 즉시 체결**되고, 10주가 소진되면 그때부터 **학생 간 거래**가 열립니다.

---

## 📂 프로젝트 구조

```
1st_SchoolStock  (main — 리팩토링 완료본)
├─ src/
│  ├─ com/school/stockGame/
│  │  ├─ servlet/       FrontControllerServlet · ActionFactory · Action 구현체 23개
│  │  ├─ dao/           DAO 인터페이스 7개
│  │  │  ├─ jdbc/       JDBC 구현체 · DBCP
│  │  │  └─ mybatis/    MyBatis 구현체 · DBCPMybatis
│  │  ├─ query/         SQL 상수 (1차 잔존)
│  │  └─ vo/            VO 8개
│  ├─ config/           mybatis-Config.xml · Mapper XML 7개
│  └─ test/             DAO 단위 테스트 14개 (JDBC 7 + MyBatis 7)
├─ WebContent/
│  ├─ view/             JSP 13개
│  ├─ css/ · js/        스타일 10 · 스크립트 6
│  └─ WEB-INF/lib/      gson · jstl · ojdbc5 · mybatis
├─ db/                  스키마 · 시퀀스 · 더미 데이터
└─ docs/                아키텍처 · ERD · 클래스 다이어그램 · 워크플로우
```

> `sprint1-jdbc` 브랜치는 `dao/` 아래 구현 클래스만 있고 `config/`·`mybatis` 라이브러리가 없습니다.
