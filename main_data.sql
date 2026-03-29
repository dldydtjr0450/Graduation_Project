-- 1. 고객 테이블 (Users)
-- 고객의 특성(피부타입)으로 이탈 원인 분석
CREATE TABLE Users (  
    user_id    INTEGER PRIMARY KEY AUTOINCREMENT, -- 고유 번호
    name       TEXT NOT NULL,                     -- 고객 이름 
    age        INTEGER,                           -- 나이 
    gender     TEXT CHECK(gender IN ('남', '여')), -- 성별
    skin_type  TEXT CHECK(skin_type IN ('건성', '지성', '복합성', '민감성')), -- 피부 타입별
    join_date  DATE DEFAULT (date('now'))         -- 가입일 (기본 세팅: 현재 날짜)
);

-- 2. 상품 테이블 (Products)
-- 추천 시스템에서 성분, 카테고리 추천 기준
CREATE TABLE Products (
    product_id      INTEGER PRIMARY KEY AUTOINCREMENT, 
    product_name    TEXT NOT NULL,                  -- 상품명
    category        TEXT CHECK(category IN ('스킨', '로션', '앰플', '크림')), 
    price           INTEGER NOT NULL,               -- 가격
    main_ingredient TEXT,                           -- 주요 성분 (main)
    volume          TEXT                            -- 용량 (ex:50ml, 100ml)
);

-- 3. 주문 테이블 (Orders)
-- Users, Products 링크 (구매 주기, 이탈 여부 판단 main data)
CREATE TABLE Orders (
    order_id    INTEGER PRIMARY KEY AUTOINCREMENT, 
    user_id     INTEGER,                           -- 유저 id
    product_id  INTEGER,                           -- 무얼 산지
    order_date  DATE DEFAULT (date('now')),        -- 구매일
    amount      INTEGER DEFAULT 1,                 -- 수량
    FOREIGN KEY (user_id) REFERENCES Users(user_id), 
    FOREIGN KEY (product_id) REFERENCES Products(product_id) 
);

-- 4. 행동 기록 테이블 (Logs)
-- 구매 전 단계(클릭, 장바구니)를 분석하여 이탈 징후를 미리 파악.
CREATE TABLE Logs (
    log_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id      INTEGER,
    action_type  TEXT CHECK(action_type IN ('클릭', '장바구니')), -- 장바구니 패턴 분석
    event_date   DATETIME DEFAULT (datetime('now')), -- 발생 시간
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
