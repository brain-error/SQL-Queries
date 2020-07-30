CREATE OR REPLACE FUNCTION p1(customername CHAR) RETURNS TABLE (vanme CHAR(24), tdate DATE, tamount NUMERIC) AS $$

  BEGIN
    RAISE NOTICE 'Customer name is %', customername;

    RETURN QUERY
    SELECT v.Vname, t.T_Date, t.Amount
    FROM v, c, t
    WHERE customername = c.Cname AND
          c.Account = t.Account AND
          t.Vno = v.Vno;

  END;
$$ LANGUAGE plpgsql;
