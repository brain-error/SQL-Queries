CREATE OR REPLACE FUNCTION p2(vendorname CHAR) RETURNS TABLE (cnum CHAR(6), customername CHAR(24), province CHAR(6)) AS $$

  BEGIN
    RAISE NOTICE 'Vendor name is %', vendorname;

    RETURN QUERY
    SELECT c.Account, c.Cname, c.Province
    FROM v, c, t
    WHERE vendorname = v.Vname AND
          c.Account = t.Account AND
          t.Vno = v.Vno;

  END;
$$ LANGUAGE plpgsql;
