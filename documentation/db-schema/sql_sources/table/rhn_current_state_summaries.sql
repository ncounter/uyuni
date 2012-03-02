-- created by Oraschemadoc Fri Mar  2 05:57:10 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHN_CURRENT_STATE_SUMMARIES" 
   (	"CUSTOMER_ID" NUMBER(12,0) NOT NULL ENABLE, 
	"TEMPLATE_ID" VARCHAR2(10) NOT NULL ENABLE, 
	"STATE" VARCHAR2(20) NOT NULL ENABLE, 
	"STATE_COUNT" NUMBER(9,0), 
	"LAST_CHECK" DATE, 
	 CONSTRAINT "RHN_CURRENT_STATE_SUMMARIES_PK" PRIMARY KEY ("CUSTOMER_ID", "TEMPLATE_ID", "STATE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
