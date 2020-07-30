CREATE OR REPLACE FUNCTION p7()
  RETURNS TABLE (customername CHAR(24), custormerbal NUMERIC) AS $$

    DECLARE
      c1 cursor FOR
      SELECT c.Account, c.Cname, c.Cbalance, c.Crlimit
      FROM c;

    DECLARE
      service_percent NUMERIC = 0.10;
      portion NUMERIC;
      c_account CHAR(6);
      c_balance NUMERIC;
      c_name CHAR(24);
      c_limit NUMERIC;

  BEGIN
      RAISE INFO 'Customers over credit limit:';
      RAISE INFO ' ';

      OPEN c1;
      LOOP
        FETCH c1 INTO c_account, c_name, c_balance, c_limit;
        EXIT WHEN NOT FOUND;

        IF (c_balance > c_limit) THEN
          portion = (c_balance - c_limit) * service_percent;
          c_balance = c_balance + portion;

          UPDATE c
          SET Cbalance = c_balance
          WHERE Account = c_account;

          RAISE INFO 'Account Name: %', c_name;
          RAISE INFO 'New Balance: %', c_balance;
          RAISE INFO ' ';
        END IF;

    END LOOP;
    CLOSE c1;

      RETURN QUERY
      SELECT c.CName, c.Cbalance
      FROM c
      WHERE c.Cbalance > c.Crlimit;

  END;
  $$ LANGUAGE plpgsql;
