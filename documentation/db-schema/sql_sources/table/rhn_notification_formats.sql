-- created by Oraschemadoc Fri Mar  2 05:57:11 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHN_NOTIFICATION_FORMATS" 
   (	"RECID" NUMBER(12,0) NOT NULL ENABLE, 
	"CUSTOMER_ID" NUMBER(12,0), 
	"DESCRIPTION" VARCHAR2(255) NOT NULL ENABLE, 
	"SUBJECT_FORMAT" VARCHAR2(4000), 
	"BODY_FORMAT" VARCHAR2(4000) NOT NULL ENABLE, 
	"MAX_SUBJECT_LENGTH" NUMBER(12,0), 
	"MAX_BODY_LENGTH" NUMBER(12,0) DEFAULT (1920) NOT NULL ENABLE, 
	"REPLY_FORMAT" VARCHAR2(4000), 
	 CONSTRAINT "RHN_NTFMT_RECID_PK" PRIMARY KEY ("RECID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "RHN_NTFMT_CUSTOMER_FK" FOREIGN KEY ("CUSTOMER_ID")
	  REFERENCES "SPACEWALK"."WEB_CUSTOMER" ("ID") ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
