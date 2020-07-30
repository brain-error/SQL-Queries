CREATE OR REPLACE FUNCTION p8(trans_num CHAR(6), ven_num CHAR(6), cust_account CHAR(6), tamount NUMERIC)
  RETURNS VOID AS $$

DECLARE
      c1 cursor FOR
        SELECT *
        FROM c;
      c2 cursor FOR
        SELECT *
        FROM v;
      c3 cursor FOR
        SELECT *
        FROM t;
DECLARE
  c_account CHAR(6);
  c_name CHAR(24);
  c_province CHAR(6);
  c_balance NUMERIC;
  c_crlimit	NUMERIC;
  v_no CHAR(6);
  v_name CHAR(24);
  v_city CHAR(24);
  v_balance NUMERIC;
  t_no CHAR(6);
  t_amount NUMERIC;
  t_tdate DATE;

BEGIN

  INSERT INTO t(Tno, Vno, Account, T_Date, Amount) VALUES
  (trans_num, ven_num, cust_account, CURRENT_DATE, tamount);

  UPDATE v
  SET Vbalance = Vbalance + tamount
  WHERE Vno = ven_num;

  UPDATE c
  SET Cbalance = Cbalance + tamount
  WHERE Account = cust_account;

  OPEN c1;
  LOOP
    FETCH c1 INTO c_account, c_name, c_province, c_balance, c_crlimit;
    EXIT WHEN NOT FOUND;

    IF c_account = cust_account THEN
      RAISE INFO '--Customer--';
			RAISE INFO 'Account: %', c_account;
			RAISE INFO 'Name: %', c_name;
			RAISE INFO 'Province: %', c_province;
			RAISE INFO 'Balance: %', c_balance;
			RAISE INFO 'CrLimit: %', c_crlimit;
			RAISE INFO  ' ';

    END IF;
  END LOOP;
  CLOSE c1;

  OPEN c2;
  LOOP
    FETCH c2 INTO v_no, v_name, v_city, v_balance;
    EXIT WHEN NOT FOUND;

    IF v_no = ven_num THEN
      RAISE INFO '--Vendor--';
      RAISE INFO 'Vno: %', v_no;
      RAISE INFO 'Name: %', v_name;
      RAISE INFO 'City: %', v_city;
      RAISE INFO 'Balance: %', v_balance;
      RAISE INFO  ' ';

    END IF;
  END LOOP;
  CLOSE c2;

  OPEN c3;
  LOOP
    FETCH c3 INTO t_no, v_no, c_account, t_tdate, t_amount;
    EXIT WHEN NOT FOUND;

    IF t_no = trans_num THEN
      RAISE INFO '--Transaction--';
      RAISE INFO 'Tno: %', t_no;
      RAISE INFO 'Vno: %', v_no;
      RAISE INFO 'Account: %', c_account;
      RAISE INFO 'Amount: %', t_amount;
      RAISE INFO 'Date: %', t_tdate;
      RAISE INFO  ' ';

    END IF;
  END LOOP;
  CLOSE c3;

END;
$$ LANGUAGE plpgsql;
