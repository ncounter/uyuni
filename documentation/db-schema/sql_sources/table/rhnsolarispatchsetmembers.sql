-- created by Oraschemadoc Fri Mar  2 05:57:00 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHNSOLARISPATCHSETMEMBERS" 
   (	"PATCH_ID" NUMBER NOT NULL ENABLE, 
	"PATCH_SET_ID" NUMBER NOT NULL ENABLE, 
	"PATCH_ORDER" NUMBER, 
	"CREATED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	"MODIFIED" DATE DEFAULT (sysdate) NOT NULL ENABLE, 
	 CONSTRAINT "RHN_SOLARIS_PSM_PID_FK" FOREIGN KEY ("PATCH_ID")
	  REFERENCES "SPACEWALK"."RHNPACKAGE" ("ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "RHN_SOLARIS_PSM_PSID_FK" FOREIGN KEY ("PATCH_SET_ID")
	  REFERENCES "SPACEWALK"."RHNPACKAGE" ("ID") ON DELETE CASCADE ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
