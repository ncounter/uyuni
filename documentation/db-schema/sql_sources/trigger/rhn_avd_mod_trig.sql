-- created by Oraschemadoc Fri Mar  2 05:58:04 2012
-- visit http://www.yarpen.cz/oraschemadoc/ for more info

  CREATE OR REPLACE TRIGGER "SPACEWALK"."RHN_AVD_MOD_TRIG" 
before insert or update on rhnActionVirtDestroy
for each row
begin
    :new.modified := sysdate;
end;
ALTER TRIGGER "SPACEWALK"."RHN_AVD_MOD_TRIG" ENABLE
 
/
