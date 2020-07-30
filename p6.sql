CREATE OR REPLACE FUNCTION p6()
  RETURNS VOID AS $$

  DECLARE
    c1 cursor FOR
    SELECT v.Vno, v.Vname, v.Vbalance
    FROM v;

  DECLARE
    service_percent NUMERIC = 0.04;
    new_balance NUMERIC;
    subtract NUMERIC;
    ven_num CHAR(6);
    ven_name CHAR(24);

BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO ven_num, ven_name, new_balance;
      EXIT WHEN NOT FOUND;

      subtract = new_balance * service_percent;
      new_balance = new_balance - subtract;

      UPDATE v
      SET Vbalance = new_balance
      WHERE Vno = ven_num;

      RAISE INFO 'Account Name: %', ven_name;
      RAISE INFO 'Account Fee: $%', subtract;
      RAISE INFO 'New Balance: %', new_balance;
      RAISE INFO ' ';

  END LOOP;
  CLOSE c1;

END;
$$ LANGUAGE plpgsql;
