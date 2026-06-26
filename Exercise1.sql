-- ===========================================
-- Exercise 1: Control Structures
-- ===========================================

------------------------------------------------
-- Scenario 1:
-- Apply 1% discount to loan interest rate
-- for customers above 60 years.
------------------------------------------------

BEGIN
    FOR c IN (
        SELECT CUSTOMERID, AGE
        FROM CUSTOMERS
    )
    LOOP
        IF c.AGE > 60 THEN
            UPDATE CUSTOMERS
            SET LOANINTERESTRATE = LOANINTERESTRATE - 1
            WHERE CUSTOMERID = c.CUSTOMERID;
        END IF;
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Interest Rate Updated Successfully');

END;
/

------------------------------------------------
-- Scenario 2:
-- Promote customers with balance greater than
-- 10000 to VIP.
------------------------------------------------

BEGIN
    FOR c IN (
        SELECT CUSTOMERID, BALANCE
        FROM CUSTOMERS
    )
    LOOP
        IF c.BALANCE > 10000 THEN
            UPDATE CUSTOMERS
            SET ISVIP = 'TRUE'
            WHERE CUSTOMERID = c.CUSTOMERID;
        ELSE
            UPDATE CUSTOMERS
            SET ISVIP = 'FALSE'
            WHERE CUSTOMERID = c.CUSTOMERID;
        END IF;
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('VIP Status Updated Successfully');

END;
/

------------------------------------------------
-- Scenario 3:
-- Print reminders for loans due within
-- the next 30 days.
------------------------------------------------

BEGIN
    FOR r IN (
        SELECT c.NAME,
               l.DUEDATE
        FROM CUSTOMERS c
        JOIN LOANS l
          ON c.CUSTOMERID = l.CUSTOMERID
        WHERE l.DUEDATE <= SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: ' || r.NAME ||
            ' - Loan Due Date: ' ||
            TO_CHAR(r.DUEDATE,'DD-MON-YYYY')
        );
    END LOOP;

END;
/
