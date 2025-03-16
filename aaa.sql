-- 1) 既存テーブルを削除
DROP TABLE IF EXISTS "dev"."public"."event_log";

-- 2) 新規テーブルを作成 (列名を JSONキーと同じ大文字小文字に)
CREATE TABLE "dev"."public"."event_log" (
    "timestamp" TIMESTAMP,
    "level"     VARCHAR(10),
    "message"   VARCHAR(255),
    "userId"    INT,
    "sessionId" VARCHAR(50),
    "ipAddress" VARCHAR(50),
    "errorCode" INT
);

-- 3) JSONPathsファイルを使った COPY
COPY "dev"."public"."event_log"
FROM 's3://custum-log-bucket-01/sample-logs.jsonl'
IAM_ROLE 'arn:aws:iam::677276118659:role/CustumRedShiftS3ReadRole'
FORMAT AS JSON 's3://custum-log-bucket-01/jsonpathfiles/event_logpaths.json'
TIMEFORMAT 'auto'
REGION 'ap-northeast-1';

-- 4) データ確認
SELECT *
FROM "dev"."public"."event_log";
