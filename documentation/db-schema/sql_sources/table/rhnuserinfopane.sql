-- created by Oraschemadoc Fri Mar  2 05:57:04 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE TABLE "SPACEWALK"."RHNUSERINFOPANE" 
   (	"USER_ID" NUMBER NOT NULL ENABLE, 
	"PANE_ID" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "RHN_USR_INFO_PANE_UID_FK" FOREIGN KEY ("USER_ID")
	  REFERENCES "SPACEWALK"."WEB_CONTACT" ("ID") ON DELETE CASCADE ENABLE, 
	 CONSTRAINT "RHN_USR_INFO_PANE_PID_FK" FOREIGN KEY ("PANE_ID")
	  REFERENCES "SPACEWALK"."RHNINFOPANE" ("ID") ON DELETE CASCADE ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ENABLE ROW MOVEMENT 
 
/
