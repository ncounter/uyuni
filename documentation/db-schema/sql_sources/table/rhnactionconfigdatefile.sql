-- created by Oraschemadoc Fri Mar  2 05:56:30 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHNACTIONCONFIGDATEFILE" 
   (	"ACTION_ID" NUMBER NOT NULL ENABLE, 
	"FILE_NAME" VARCHAR2(512) NOT NULL ENABLE, 
	"FILE_TYPE" CHAR(1) NOT NULL ENABLE, 
	"CREATED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	 CONSTRAINT "RHN_ACTIONCD_FILE_FT_CK" CHECK (file_type in ('W','B')) ENABLE, 
	 CONSTRAINT "RHN_ACTIONCD_FILE_AID_FK" FOREIGN KEY ("ACTION_ID")
	  REFERENCES "SPACEWALK"."RHNACTION" ("ID") ON DELETE CASCADE ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
