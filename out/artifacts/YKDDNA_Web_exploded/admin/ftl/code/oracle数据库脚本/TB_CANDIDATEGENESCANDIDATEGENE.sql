-- ----------------------------
-- Table structure for "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"
-- ----------------------------
-- DROP TABLE "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE";
CREATE TABLE "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE" (
	"GENEENSGENE" VARCHAR2(255 BYTE) NULL ,
	"TYPE" VARCHAR2(255 BYTE) NULL ,
	"SUMMARY" VARCHAR2(255 BYTE) NULL ,
	"SUPPLEMENT" VARCHAR2(255 BYTE) NULL ,
	"REFERENCE" VARCHAR2(255 BYTE) NULL ,
	"PMID" VARCHAR2(255 BYTE) NULL ,
	"CANDIDATEGENE_ID" VARCHAR2(100 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE
;

COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."GENEENSGENE" IS 'Gene.ensGene';
COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."TYPE" IS '表型';
COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."SUMMARY" IS '表型分类';
COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."SUPPLEMENT" IS '补充';
COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."REFERENCE" IS '参考文献';
COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."PMID" IS 'PMID';
COMMENT ON COLUMN "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"."CANDIDATEGENE_ID" IS 'ID';

-- ----------------------------
-- Indexes structure for table TB_CANDIDATEGENESCANDIDATEGENE
-- ----------------------------

-- ----------------------------
-- Checks structure for table "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"

-- ----------------------------

ALTER TABLE "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE" ADD CHECK ("CANDIDATEGENE_ID" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE"
-- ----------------------------
ALTER TABLE "C##NEWO"."TB_CANDIDATEGENESCANDIDATEGENE" ADD PRIMARY KEY ("CANDIDATEGENE_ID");
