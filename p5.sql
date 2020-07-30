CREATE OR REPLACE FUNCTION p5()
  RETURNS TABLE (vnum CHAR(6), vendorname CHAR(24), balance NUMERIC) AS $$

  DECLARE
    c1 cursor FOR
      SELECT t.Vno, t.Amount
      FROM t;

  DECLARE
    trans_amount NUMERIC;
    ven_num CHAR(24);

BEGIN
  OPEN c1;
  LOOP
    FETCH c1 INTO ven_num, trans_amount;
    EXIT WHEN NOT FOUND;

    IF (trans_amount > 1) THEN

      --Change the transactions
      UPDATE v
      SET Vbalance = Vbalance + trans_amount
      WHERE Vno = ven_num;

    END IF;
  END LOOP;
  CLOSE c1;

  RETURN QUERY
  SELECT v.Vno, v.Vname, v.Vbalance
  FROM v;

END;
$$ LANGUAGE plpgsql;
