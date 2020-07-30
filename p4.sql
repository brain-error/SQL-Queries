CREATE OR REPLACE FUNCTION p4()
  RETURNS TABLE (customername CHAR(24), account CHAR(6), tamount NUMERIC, vendorname CHAR(24)) AS $$

  DECLARE c1 cursor FOR
    SELECT c.Account
    FROM c
    WHERE NOT EXISTS (SELECT c.Account FROM t WHERE c.Account = t.Account);

  DECLARE cust_account CHAR(6);

  BEGIN

    OPEN c1;
    LOOP
      FETCH c1 INTO cust_account;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Account % : No transactions', cust_account;
    END LOOP;
    CLOSE c1;

    RETURN QUERY
    SELECT DISTINCT ON (c.Cname)
                        c.Cname,
                        c.Account,
                        t.Amount,
                        v.Vname
    FROM c, t, v
    WHERE t.Account = c.Account AND
          v.Vno = t.Vno
    ORDER BY c.Cname, t.T_Date DESC;



  END;
$$ LANGUAGE plpgsql;
