-- created by Oraschemadoc Fri Mar  2 05:57:16 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."WEB_CUSTOMER" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"NAME" VARCHAR2(128) NOT NULL ENABLE, 
	"STAGING_CONTENT_ENABLED" CHAR(1) DEFAULT ('N') NOT NULL ENABLE, 
	"CREATED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	 CONSTRAINT "WEB_CUSTOMER_STAGE_CONTENT_CHK" CHECK (staging_content_enabled in ( 'Y' , 'N' )) ENABLE, 
	 CONSTRAINT "WEB_CUSTOMER_ID_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
