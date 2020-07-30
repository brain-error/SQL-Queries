CREATE OR REPLACE FUNCTION p3(new_account CHAR, new_cname CHAR, new_province CHAR, new_limit NUMERIC)
  RETURNS TABLE (account CHAR(6), customername CHAR(24), province CHAR(6), balance NUMERIC, climit NUMERIC) AS $$

  BEGIN

    INSERT INTO c(Account, Cname, Province, Cbalance, Crlimit) VALUES (new_account, new_cname, new_province, 00.00, new_limit);
    RETURN QUERY
    SELECT  c.Account,
            c.Cname,
            c.Province,
            c.Cbalance ,
            c.Crlimit
    FROM c;

  END;
$$ LANGUAGE plpgsql;
