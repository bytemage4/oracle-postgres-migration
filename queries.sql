DECLARE
  v_trigger_body LONG;
BEGIN
  SELECT TRIGGER_BODY 
  INTO v_trigger_body
  FROM ALL_TRIGGERS 
  WHERE TRIGGER_NAME = 'Your_Trigger_Name';
  
  DBMS_OUTPUT.PUT_LINE(v_trigger_body);
END;
